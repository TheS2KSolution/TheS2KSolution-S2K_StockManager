package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.LigneCommandeClient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LigneCommandeClientRepository extends JpaRepository<LigneCommandeClient, Integer> {

    Optional<LigneCommandeClient> findByAllByCommandeClientId(Integer idCommande);
}
