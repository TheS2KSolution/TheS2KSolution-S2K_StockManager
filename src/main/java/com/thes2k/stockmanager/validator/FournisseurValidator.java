package com.thes2k.stockmanager.validator;


import com.thes2k.stockmanager.dto.FournisseurDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class FournisseurValidator {
    public static List<String> validate(FournisseurDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le nom Fournisseur");
            errors.add("Veillez renseigner lePrenom Fournisseur");
            errors.add("Veillez renseigner le Mail Fournisseur");
            errors.add("Veillez renseigner le numero de telephone du Fournisseur");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getNom())) {
            errors.add("Veillez renseigner le nom Fournisseur");

        }
        if (!StringUtils.hasLength(dto.getPrenom())) {
            errors.add("Veillez renseigner lePrenom Fournisseur");

        }
        if (!StringUtils.hasLength(dto.getEmail())) {
            errors.add("Veillez renseigner le Mail Fournisseur");

        }
        if (!StringUtils.hasLength(dto.getTelephone())) {
            errors.add("Veillez renseigner le numero de telephone du Fournisseur");

        }

        return errors;
    }
}
