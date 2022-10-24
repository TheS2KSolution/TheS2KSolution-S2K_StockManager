package com.thes2k.stockmanager.repository;


import com.thes2k.stockmanager.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Optional<Category> findCategoryByCodeCategory(String codeCategory);
}
