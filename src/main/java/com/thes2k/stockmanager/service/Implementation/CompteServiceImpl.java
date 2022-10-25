package com.thes2k.stockmanager.service.Implementation;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.thes2k.stockmanager.model.*;
import com.thes2k.stockmanager.repository.CompteRepository;
import com.thes2k.stockmanager.repository.RoleRepository;
import com.thes2k.stockmanager.repository.SuperAdminRepository;
import com.thes2k.stockmanager.service.feature.CompteService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class CompteServiceImpl implements CompteService, UserDetailsService {
    private final CompteRepository compteRepository;
    private  final SuperAdminRepository superAdminRepository;
    private final RoleRepository roleRepository;

    @Override
    public void refreshToken(HttpServletRequest request, HttpServletResponse response) {
        String authorizationHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if(authorizationHeader != null && authorizationHeader.startsWith("Bearer ")){
            try
            {
                String refreshToken = authorizationHeader.substring("Bearer ".length());
                Algorithm algorithm = Algorithm.HMAC256("secret".getBytes());
                JWTVerifier jwtVerifier = JWT.require(algorithm).build();
                DecodedJWT decodedJWT = jwtVerifier.verify(refreshToken);
                String username = decodedJWT.getSubject();
                Compte account = compteRepository.findCompteByEmailOrPhoneOrUsername(username);
                String newAccessToken = JWT.create()
                        .withSubject(account.getUsername())
                        .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 90L))
                        .withIssuer(request.getRequestURL().toString())
                        .withClaim("roles", account.getRoles().stream().map(role -> role.getRoleName().toString()).collect(Collectors.toList()))
                        .sign(algorithm);
                Map<String, String> tokens = new HashMap<>();
                tokens.put("accessToken", newAccessToken);
                tokens.put("refreshToken", refreshToken);
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                new ObjectMapper().writeValue(response.getOutputStream(), tokens);
            }
            catch (Exception e)
            {
                Map<String, String> output = new HashMap<>();
                output.put("message", e.getMessage());
                output.put("status", String.valueOf(HttpStatus.FORBIDDEN.value()));
                response.setHeader("message", e.getMessage());
                response.setStatus(HttpStatus.FORBIDDEN.value());
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);

                try {
                    new ObjectMapper().writeValue(response.getOutputStream(), output);
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }

        }else {
            throw new RuntimeException("Refresh token is missing !");
        }
    }

    @Override
    public UserDetails loadUserByUsername(String usernameOrEmailOrPhone) throws UsernameNotFoundException {
        Compte compte = compteRepository.findCompteByEmailOrPhoneOrUsername(usernameOrEmailOrPhone);

        if (compte == null || compte.getEtatCompte() == Etat_Compte.DESACTIVER || compte.getEtatCompte() == Etat_Compte.SUPPRIMER)
            throw new UsernameNotFoundException("We're not found this account !");

        Collection<SimpleGrantedAuthority> authorities = new HashSet<>();
        compte.getRoles().forEach(role -> {
            authorities.add(new SimpleGrantedAuthority(role.getRoleName().toString()));
        });

        return new User(compte.getUsername(), compte.getPassword(), authorities);
    }

    @Override
    public void saveRole(Roles roles){
        Roles rolesExisting = roleRepository.findByRoleName(roles.getRoleName());
        if (rolesExisting != null)
            return;

        roleRepository.save(roles);
    }

    @Transactional
    @Override
    public void addRoleToCompte(String usernameOrEmailOrPhone, RoleName roleName) {
        Compte compte = compteRepository.findCompteByEmailOrPhoneOrUsername(usernameOrEmailOrPhone);
        Roles roles = roleRepository.findByRoleName(roleName);

        if(compte == null || roleName == null)
            return;

        compte.getRoles().add(roles);
    }

    @Override
    public Boolean saveCompte(Compte compte) {
        Entreprise entreprise = new Entreprise();
        boolean isCompteExists = checkIfCompteExists(compte.getUsername(), compte.getEmail(), compte.getPhone());
        if (!isCompteExists){
            return false;
        }
        compte.setPassword(new BCryptPasswordEncoder().encode(compte.getPassword()));
        entreprise.setCodeEntreprise("ENT" + entreprise.getId());
        compteRepository.save(compte);
        return true;
    }

    @Override
    public List<Compte> listCompte() {
        return compteRepository.findAll();
    }

    @Override
    public Compte detailCompte(Long id) {
        if (id == null)
            return null;

        return compteRepository.findById(id).orElseThrow();
    }

    @Override
    public void disable(Long id) {
        Compte disableCompte = compteRepository.findById(id).orElseThrow();
        disableCompte.setEtatCompte(Etat_Compte.DESACTIVER);
        compteRepository.save(disableCompte);
    }

    @Override
    public void enable(Long id) {
        Compte enableCompte = compteRepository.findById(id).orElseThrow();
        enableCompte.setEtatCompte(Etat_Compte.ACTIVER);
        compteRepository.save(enableCompte);
    }

    @Override
    public void delete(Long id) {
        Compte deleteCompte = compteRepository.findById(id).orElseThrow();
        deleteCompte.setEtatCompte(Etat_Compte.SUPPRIMER);
        compteRepository.save(deleteCompte);
    }

    @Override
    public Boolean saveAdmin(SuperAdmin superAdmin) {

        boolean isCompteExists = checkIfCompteExists(superAdmin.getUsername(), superAdmin.getEmail(), superAdmin.getPhone());

        if (!isCompteExists){
            return false;
        }

        superAdmin.setPassword(new BCryptPasswordEncoder().encode(superAdmin.getPassword()));
        superAdminRepository.save(superAdmin);
        return true;
    }

    public boolean checkIfCompteExists(String username, String email, String phone){
        Compte existUsername = compteRepository.findByUsername(username);
        Compte existEmail = compteRepository.findByEmail(email);
        Compte existPhone = compteRepository.findByPhone(phone);

        return existEmail == null && existUsername == null && existPhone == null;
    }
}
