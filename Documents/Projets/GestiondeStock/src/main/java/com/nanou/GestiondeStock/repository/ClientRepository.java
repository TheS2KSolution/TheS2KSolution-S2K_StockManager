package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ClientRepository extends JpaRepository<Client, Integer> {
    Optional<Client> findCategoryByCodeClient(String codeClient);

    @Override
    Optional<Client> findById(Integer integer);
}
