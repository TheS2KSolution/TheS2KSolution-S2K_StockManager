package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.ArticleDto;
import com.nanou.GestiondeStock.dto.CategoryDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Article;
import com.nanou.GestiondeStock.model.Category;
import com.nanou.GestiondeStock.repository.ArticleRepository;
import com.nanou.GestiondeStock.repository.CategoryRepository;
import com.nanou.GestiondeStock.services.CategoryService;
import com.nanou.GestiondeStock.validator.ArticleValidator;
import com.nanou.GestiondeStock.validator.CategoryValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CategoryServiceImpl implements CategoryService {

    private CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;

    }

    @Override
    public CategoryDto save(CategoryDto dto) {
        List<String> errors = CategoryValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("Categorie n est pas valide{}", dto);
            throw new InvalidEntityException("La Categorie n est pas valide", ErrorCodes.CATEGORY_NOT_VALID, errors);
        }
        return CategoryDto.fromEntity(categoryRepository.save(
                CategoryDto.toEntity(dto)
        ));
    }

    @Override
    public CategoryDto findByCodeCategory(String codeCategory) {
        if (!StringUtils.hasLength(codeCategory)) {
            log.error("Category Code est nul");
            return null;
        }
        Optional<Category> category = categoryRepository.findCategoryByCodeCategory(codeCategory);

        return Optional.of(CategoryDto.fromEntity(category.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun category avec le CODE =" + codeCategory + "n'ete trouve dans la Base",
                        ErrorCodes.CATEGORY_NOT_FOUND)
        );
    }

    @Override
    public CategoryDto finById(Integer id) {
        if (id == null) {
            log.error("Article ID est nul");
            return null;
        }
        Optional<Category> category = categoryRepository.findById(id);

        return Optional.of(CategoryDto.fromEntity(category.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun categorie avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.CATEGORY_NOT_FOUND)
        );
    }

    @Override
    public List<CategoryDto> findAll() {
        return categoryRepository.findAll().stream()
                .map(CategoryDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("categorie ID est nul");

        }
        categoryRepository.deleteById(id);

    }
}
