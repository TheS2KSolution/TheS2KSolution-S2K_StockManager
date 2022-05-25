package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.CategoryDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class CategoryValidator {
    public static List<String> validate(CategoryDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null || !StringUtils.hasLength(dto.getCodeCategory())) {
            errors.add("Veuillez Renseigner le code de la categorie");

        }
        return errors;
    }
}
