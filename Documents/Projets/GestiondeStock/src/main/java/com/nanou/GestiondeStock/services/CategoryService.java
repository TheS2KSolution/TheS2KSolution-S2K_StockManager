package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.CategoryDto;


import java.util.List;

public interface CategoryService {
    CategoryDto save(CategoryDto dto);

    CategoryDto findByCodeCategory(String codeCategory);

    CategoryDto finById(Integer id);

    List<CategoryDto> findAll();

    void delete(Integer id);
}
