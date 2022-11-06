package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    Utilisateur findByUsername(String username);

    Utilisateur findByEmail(String email);

    Utilisateur findByPhone(String phone);
}
