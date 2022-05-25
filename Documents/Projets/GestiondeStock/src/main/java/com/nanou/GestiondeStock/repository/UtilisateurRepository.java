package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface UtilisateurRepository extends JpaRepository<Utilisateur, Integer> {
    Optional<Utilisateur> findCategoryByCodeUtilisateur(String codeUtilisateur);
    Optional<Utilisateur> findUtilisateursByEmail (String email);
}
