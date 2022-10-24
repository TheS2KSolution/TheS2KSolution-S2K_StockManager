package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.Fournisseur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FournisseurRepository extends JpaRepository<Fournisseur, Integer> {
    Optional<Fournisseur> findByCodeFournisseur(String codeFournisseur);
}
