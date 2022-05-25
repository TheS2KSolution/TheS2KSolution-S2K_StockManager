package com.nanou.GestiondeStock.services.auth;

import com.nanou.GestiondeStock.dto.UtilisateurDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.model.Utilisateur;
import com.nanou.GestiondeStock.model.auth.ExtendedUser;
import com.nanou.GestiondeStock.repository.UtilisateurRepository;
import com.nanou.GestiondeStock.services.UtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ApplicationUserDetailsService implements UserDetailsService {

    @Autowired
    private UtilisateurService service;


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UtilisateurDto utilisateur = service.findByEmail(email);
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        utilisateur.getRoles().forEach(roles -> authorities.add(new SimpleGrantedAuthority(roles.getRoleName())));
        return new ExtendedUser(utilisateur.getEmail(),utilisateur.getMotDePasse(),utilisateur.getEntreprise().getId(),authorities);


    }
}
