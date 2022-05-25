package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.CategoryApi;
import com.nanou.GestiondeStock.dto.CategoryDto;
import com.nanou.GestiondeStock.services.CategoryService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CategoryController implements CategoryApi {
    private CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @Override
    public CategoryDto save(CategoryDto dto) {
        return categoryService.save(dto);

    }

    @Override
    public CategoryDto findById(Integer id) {
        return categoryService.finById(id);
    }

    @Override
    public CategoryDto findByCodeCategory(String codeCategory) {
        return categoryService.findByCodeCategory(codeCategory);
    }

    @Override
    public List<CategoryDto> findAll() {
        return categoryService.findAll();
    }

    @Override
    public void delete(Integer id) {
        categoryService.delete(id);

    }
}
