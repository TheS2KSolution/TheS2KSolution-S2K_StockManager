package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.CommandeClientDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class CommandeClientValidator {
    public static List<String> validate(CommandeClientDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code de la Commande du Client");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getCode())) {
            errors.add("Veillez renseigner le Code de la Commande du Client");

        }

        return errors;
    }

}
