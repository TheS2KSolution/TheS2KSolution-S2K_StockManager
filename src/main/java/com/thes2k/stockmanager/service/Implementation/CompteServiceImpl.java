package com.thes2k.stockmanager.service.Implementation;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.thes2k.stockmanager.dto.CompteDto;
import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.mapper.CompteMapper;
import com.thes2k.stockmanager.mapper.EntrepriseMapper;
import com.thes2k.stockmanager.model.*;
import com.thes2k.stockmanager.repository.CompteRepository;
import com.thes2k.stockmanager.repository.EntrepriseRepository;
import com.thes2k.stockmanager.repository.RoleRepository;
import com.thes2k.stockmanager.repository.SuperAdminRepository;
import com.thes2k.stockmanager.service.feature.CompteService;
import com.thes2k.stockmanager.validator.CompteValidator;
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
@Getter
@Setter
@RequiredArgsConstructor
public class CompteServiceImpl implements CompteService, UserDetailsService {
    private final CompteRepository compteRepository;
    private final SuperAdminRepository superAdminRepository;
    private final RoleRepository roleRepository;
    private final Response response;
    private final CompteMapper compteMapper;
    private final EntrepriseRepository entrepriseRepository;
    private final EntrepriseMapper entrepriseMapper;

    @Override
    public void refreshToken(HttpServletRequest request, HttpServletResponse response) {
        String authorizationHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            try {
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
            } catch (Exception e) {
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

        } else {
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
    public Response saveRole(Roles roles) {
        Roles rolesExisting = roleRepository.findByRoleName(roles.getRoleName());
        if (rolesExisting != null) {
            response.setStatus(0);
            response.setMsg("Role non enregitré");
        } else {
            response.setStatus(1);
            response.setMsg("Role ajouté avec succes");
            roleRepository.save(roles);
        }
        return response;
    }

    @Transactional
    @Override
    public Response addRoleToCompte(String usernameOrEmailOrPhone, RoleName roleName) {
        Compte compte = compteRepository.findCompteByEmailOrPhoneOrUsername(usernameOrEmailOrPhone);
        Roles roles = roleRepository.findByRoleName(roleName);

        if (compte == null || roleName == null) {
            response.setStatus(0);
            response.setMsg("Role non ajouté au compte");
        } else {
            response.setStatus(1);
            response.setMsg("Role ajouté au compte avec succes ");
            compte.getRoles().add(roles);
        }
        return response;

    }

    @Override
    public Response saveCompte(CompteDto compteDto) {
        boolean isCompteExists = checkIfCompteExists(compteDto.getUsername(), compteDto.getEmail(), compteDto.getPhone());
        Compte compte = compteMapper.fromEntity(compteDto);
        EntrepriseDto entrepriseDto = new EntrepriseDto();
        Entreprise entreprise = entrepriseMapper.fromEntity(entrepriseDto);
        List<String> errors = CompteValidator.validate(compteDto);

        if (!errors.isEmpty()) {
            throw new InvalidEntityException(-1, "Merci de bien verifier vos informations", errors);
        } else if (!isCompteExists) {
            response.setStatus(0);
            response.setMsg("ce compte existe déja ");
        } else {
            compteDto.setPassword(new BCryptPasswordEncoder().encode(compte.getPassword()));
            compteRepository.save(compte);
            response.setStatus(1);
            response.setMsg("Compte enregistrer avec succes");
        }

        return response;
    }

    @Override
    public List<CompteDto> listCompte() {

        return compteRepository.findAll().stream().map(compteMapper::toEntity).collect(Collectors.toList());
    }


    @Override
    public Compte detailCompte(Long id) {
        if (id == null)
            return null;

        return compteRepository.findById(id).orElseThrow();
    }

    @Override
    public Response disable(Long id) {
        if (id == null) {
            response.setStatus(0);
            response.setMsg("aucun article n'appartient a ce id:" + id);
        } else {
            Compte disableCompte = compteRepository.findById(id).orElseThrow();
            disableCompte.setEtatCompte(Etat_Compte.DESACTIVER);
            compteRepository.save(disableCompte);
            response.setStatus(1);
            response.setMsg("Article désactivé avec succes");
        }
        return response;
    }

    @Override
    public Response enable(Long id) {
        if (id == null) {
            response.setStatus(0);
            response.setMsg("aucun article n'appartient a ce id:" + id);
        } else {
            Compte enableCompte = compteRepository.findById(id).orElseThrow();
            enableCompte.setEtatCompte(Etat_Compte.ACTIVER);
            compteRepository.save(enableCompte);
            response.setStatus(1);
            response.setMsg("Article activé avec succes");

        }
        return response;

    }

    @Override
    public Response delete(Long id) {
        if (id == null) {
            response.setStatus(0);
            response.setMsg("aucun article n'appartient a ce id:" + id);
        } else {
            Compte deleteCompte = compteRepository.findById(id).orElseThrow();
            deleteCompte.setEtatCompte(Etat_Compte.SUPPRIMER);
            compteRepository.save(deleteCompte);
            response.setStatus(1);
            response.setMsg("Article supprimé avec succes");
        }
        return response;

    }

    @Override
    public Boolean saveAdmin(SuperAdmin superAdmin) {

        boolean isCompteExists = checkIfCompteExists(superAdmin.getUsername(), superAdmin.getEmail(), superAdmin.getPhone());

        if (!isCompteExists) {
            return false;
        }

        superAdmin.setPassword(new BCryptPasswordEncoder().encode(superAdmin.getPassword()));
        superAdminRepository.save(superAdmin);
        return true;
    }

    public boolean checkIfCompteExists(String username, String email, String phone) {
        Compte existUsername = compteRepository.findByUsername(username);
        Compte existEmail = compteRepository.findByEmail(email);
        Compte existPhone = compteRepository.findByPhone(phone);
        return existEmail == null && existUsername == null && existPhone == null;

    }
}
