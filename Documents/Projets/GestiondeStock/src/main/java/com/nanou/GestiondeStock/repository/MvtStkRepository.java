package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.MvtStk;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MvtStkRepository extends JpaRepository<MvtStk, Integer> {
    Optional<MvtStk> findCategoryByCodeMvtStk(String codeMvtStk);
}
