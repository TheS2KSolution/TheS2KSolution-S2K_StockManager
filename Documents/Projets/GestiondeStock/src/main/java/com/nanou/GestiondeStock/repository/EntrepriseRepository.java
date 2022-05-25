package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Entreprise;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface EntrepriseRepository extends JpaRepository<Entreprise, Integer> {
    Optional<Entreprise> findCategoryByCodeEntreprise(String codeEntreprise);
}
