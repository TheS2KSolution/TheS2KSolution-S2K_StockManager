package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.CommandeClient;
import com.nanou.GestiondeStock.model.LigneCommandeClient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CommandeClientRepository extends JpaRepository<CommandeClient, Integer> {
    Optional<CommandeClient> findCommandeClientByCode(String code);
    Optional<LigneCommandeClient> findByAllByCommandeClientId(Integer idCommande);

}
