package com.nanou.GestiondeStock.repository;

import com.nanou.GestiondeStock.model.Category;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Optional<Category> findCategoryByCodeCategory(String codeCategory);
}
