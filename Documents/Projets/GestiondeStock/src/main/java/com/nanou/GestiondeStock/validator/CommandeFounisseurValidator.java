package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.CommandeFournisseurDto;
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
        if (!StringUtils.hasLength(dto.getCode())) {
            errors.add("Veillez renseigner le Code de la Commande du Founisseur");

        }

        return errors;
    }

}
