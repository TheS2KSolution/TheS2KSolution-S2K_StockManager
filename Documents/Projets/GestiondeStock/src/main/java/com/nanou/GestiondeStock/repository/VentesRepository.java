package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Ventes;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VentesRepository extends JpaRepository<Ventes, Integer> {
    Optional<Ventes> findVenteByCode(String code);

}
