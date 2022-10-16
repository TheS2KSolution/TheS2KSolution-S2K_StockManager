package com.thes2k.stockmanager.serviceImpl;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.Etat;
import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import com.thes2k.stockmanager.repository.CompteRepository;
import com.thes2k.stockmanager.repository.RoleRepo;
import com.thes2k.stockmanager.service.CompteService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
@Service
@RequiredArgsConstructor
public class CompteServiceImpl implements CompteService, UserDetailsService {
    private final CompteRepository compteRepository;
    private final RoleRepo roleRepo;

    @Override
    public UserDetails loadUserByUsername(String usernameOrEmailOrPhone) throws UsernameNotFoundException {
        Compte compte = compteRepository.findCompteByEmailOrPhoneOrUsername(usernameOrEmailOrPhone);

        if (compte == null || compte.getEtat() == Etat.DESACTIVER || compte.getEtat() == Etat.SUPPRIMER)
            throw new UsernameNotFoundException("We're not found this account !");

        Collection<SimpleGrantedAuthority> authorities = new HashSet<>();
        compte.getRoles().forEach(role -> {
            authorities.add(new SimpleGrantedAuthority(role.getRoleName().toString()));
        });

        return new User(compte.getUsername(), compte.getPassword(), authorities);
    }

    @Override
    public void saveRole(Roles roles){
        Roles rolesExisting = roleRepo.findByRoleName(roles.getRoleName());
        if (rolesExisting != null)
            return;

        roleRepo.save(roles);
    }

    @Transactional
    @Override
    public void addRoleToCompte(String usernameOrEmailOrPhone, RoleName roleName) {
        Compte compte = compteRepository.findCompteByEmailOrPhoneOrUsername(usernameOrEmailOrPhone);
        Roles roles = roleRepo.findByRoleName(roleName);

        if(compte == null || roleName == null)
            return;

        compte.getRoles().add(roles);
    }

    @Override
    public Boolean saveCompte(Compte compte) {
        Compte existPhone = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getPhone());
        Compte existEmail = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getEmail());
        Compte existUsername = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getUsername());
        if (existEmail !=null || existUsername !=null || existPhone !=null){
            return false;
        }

        compte.setPassword(new BCryptPasswordEncoder().encode(compte.getPassword()));
        compteRepository.save(compte);
        return true;
    }

    @Override
    public List<Compte> listCompte() {
        return compteRepository.findAll();
    }

    @Override
    public Compte detailCompte(Long id) {
        if (id == null){
            return null;
        }
        return compteRepository.findById(id).orElseThrow();
    }

    @Override
    public void disable(Long id) {
        Compte disableCompte = compteRepository.findById(id).orElseThrow();
        disableCompte.setEtat(Etat.DESACTIVER);
        compteRepository.save(disableCompte);
    }

    @Override
    public void enable(Long id) {
        Compte enableCompte = compteRepository.findById(id).orElseThrow();
        enableCompte.setEtat(Etat.ACTIVER);
        compteRepository.save(enableCompte);
    }

    @Override
    public void delete(Long id) {
        Compte deleteCompte = compteRepository.findById(id).orElseThrow();
        deleteCompte.setEtat(Etat.SUPPRIMER);
        compteRepository.save(deleteCompte);
    }
}
