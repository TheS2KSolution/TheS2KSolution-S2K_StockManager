package com.thes2k.stockmanager.repository;


import com.thes2k.stockmanager.model.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EntrepriseRepository extends JpaRepository<Entreprise, Long> {
    Entreprise findByUsername(String username);

    Entreprise findByEmail(String email);

    Entreprise findByPhone(String phone);
}
