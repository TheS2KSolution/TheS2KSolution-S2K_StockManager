package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.CategoryDto;
import com.thes2k.stockmanager.ressource.api.CategoryApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class CategoryController implements CategoryApi {

    @Override
    public CategoryDto save(CategoryDto dto) {
        return null;
    }

    @Override
    public CategoryDto findById(Integer id) {
        return null;
    }

    @Override
    public CategoryDto findByCodeCategory(String codeCategory) {
        return null;
    }

    @Override
    public List<CategoryDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
