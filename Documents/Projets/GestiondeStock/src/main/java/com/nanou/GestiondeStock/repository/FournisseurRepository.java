package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Fournisseur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FournisseurRepository extends JpaRepository<Fournisseur, Integer> {
    Optional<Fournisseur> findByCodeFournisseur(String codeFournisseur);
}
