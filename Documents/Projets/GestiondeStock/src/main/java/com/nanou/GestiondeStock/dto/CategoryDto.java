package com.nanou.GestiondeStock.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.nanou.GestiondeStock.model.Category;

import lombok.Builder;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.OneToMany;
import java.util.List;

@Builder
@Data
public class CategoryDto {
    private Integer id;
    private String codeCategory;
    private String designation;
    private Integer idEntreprise;

    @JsonIgnore
    private List<CategoryDto> categoryDtos;

    public static CategoryDto fromEntity(Category category) {
        if (category == null) {
            return null;
        }
        return CategoryDto.builder()
                .id(category.getId())
                .codeCategory(category.getCodeCategory())
                .designation(category.getDesignation())
                .idEntreprise(category.getIdEntreprise())
                .build();
    }

    public static Category toEntity(CategoryDto categoryDto) {
        if (categoryDto == null) {
            return null;
        }
        Category category = new Category();
        category.setId(categoryDto.getId());
        category.setCodeCategory(categoryDto.getCodeCategory());
        category.setIdEntreprise(categoryDto.getIdEntreprise());
        category.setDesignation(categoryDto.getDesignation());
        return category;
    }
}
