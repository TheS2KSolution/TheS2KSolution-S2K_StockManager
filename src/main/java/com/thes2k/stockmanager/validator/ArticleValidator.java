package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.ArticleDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class ArticleValidator {
    public static List<String> validate(ArticleDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le champ code de L article");
            errors.add("Veillez renseigner le champ designation de L article");
            errors.add("Veillez renseigner le champ prix unitaire de L article");
            errors.add("Veillez renseigner le champ taux TVA de L article");
            errors.add("Veillez renseigner le champ prix TTC de L article");
            errors.add("Veillez selectionner le champ Categorie");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getCodeArticle())) {
            errors.add("Veillez renseigner le champ code de L article");
        }
        if (!StringUtils.hasLength(dto.getDesignation())) {
            errors.add("Veillez renseigner le champ designation de L article");
        }
        if (dto.getPrixUnitaire() == null) {
            errors.add("Veillez renseigner le champprix unitaire de L article");
        }

        if (dto.getCategoryDto() == null) {
            errors.add("Veillez Selectionner le champ Categorie");
        }
        return errors;
    }
}
