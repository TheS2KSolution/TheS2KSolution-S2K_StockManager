package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.CategoryDto;

import java.util.List;

public interface CategoryService {
    CategoryDto save(CategoryDto dto);

    CategoryDto findByCodeCategory(String codeCategory);

    CategoryDto finById(Integer id);

    List<CategoryDto> findAll();

    void delete(Integer id);
}
