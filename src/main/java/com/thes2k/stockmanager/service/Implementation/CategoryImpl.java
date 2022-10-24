package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.CategoryDto;
import com.thes2k.stockmanager.service.feature.CategoryService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class CategoryImpl implements CategoryService {
    @Override
    public CategoryDto save(CategoryDto categoryDto) {
        return null;
    }

    @Override
    public CategoryDto findByCodeCategory(String codeCategory) {
        return null;
    }

    @Override
    public CategoryDto finById(Integer id) {
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
