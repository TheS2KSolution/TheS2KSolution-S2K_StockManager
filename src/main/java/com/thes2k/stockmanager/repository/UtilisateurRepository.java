package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    // Optional<Utilisateur> findCategoryByCodeUtilisateur(String codeUtilisateur);
    // Optional<Utilisateur> findUtilisateursByEmail(String email);
}
