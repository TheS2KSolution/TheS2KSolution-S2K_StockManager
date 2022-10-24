package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.MvtStk;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MvtStkRepository extends JpaRepository<MvtStk, Integer> {
    Optional<MvtStk> findCategoryByCodeMvtStk(String codeMvtStk);
}
