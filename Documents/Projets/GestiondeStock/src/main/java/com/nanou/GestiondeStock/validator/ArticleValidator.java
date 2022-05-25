package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.ArticleDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class ArticleValidator {
    public static List<String> validate(ArticleDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le code de L article");
            errors.add("Veillez renseigner designation de L article");
            errors.add("Veillez renseigner le prix unitaire de L article");
            errors.add("Veillez renseigner le taux TVA de L article");
            errors.add("Veillez renseigner le prix TTC de L article");
            errors.add("Veillez Sectionner une Categorie");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getCodeArticle())) {
            errors.add("Veillez renseigner le code de L article");
        }
        if (!StringUtils.hasLength(dto.getDesignation())) {
            errors.add("Veillez renseigner designation de L article");
        }
        if (dto.getPrixUnitaireht() == null) {
            errors.add("Veillez renseigner le prix unitaire de L article");
        }
        if (dto.getTauxTva() == null) {
            errors.add("Veillez renseigner le taux TVA de L article");
        }
        if (dto.getPrixUnitaireTtc() == null) {
            errors.add("Veillez renseigner le prix TTC de L article");
        }
        if (dto.getCategory() == null) {
            errors.add("Veillez Sectionner une Categorie");
        }
        return errors;
    }
}
