package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.CommandeFournisseurDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class CommandeFounisseurValidator {
    public static List<String> validate(CommandeFournisseurDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code de la Commande du Founisseur");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getCodeCommandeFournisseur())) {
            errors.add("Veillez renseigner le Code de la Commande du Founisseur");

        }

        return errors;
    }

}
