package com.thes2k.stockmanager.mapper;

import com.thes2k.stockmanager.dto.CategoryDto;
import com.thes2k.stockmanager.model.Category;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class CategoryMapper {

    public CategoryDto toEntity(Category category) {
        CategoryDto categoryDto = new CategoryDto();
        BeanUtils.copyProperties(category, categoryDto);
        return categoryDto;
    }

    public Category fromEntity(CategoryDto categoryDto) {
        Category category = new Category();
        BeanUtils.copyProperties(categoryDto, category);
        return category;
    }


}
