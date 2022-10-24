package com.thes2k.stockmanager.repository;


import com.thes2k.stockmanager.model.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface EntrepriseRepository extends JpaRepository<Entreprise, Integer> {
    Optional<Entreprise> findCategoryByCodeEntreprise(String codeEntreprise);
}
