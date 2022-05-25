package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.VentesDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class VentesValidator {
    public static List<String> validate(VentesDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code Ventes");
            return errors;
        }


        if (!StringUtils.hasLength(dto.getCode())) {
            errors.add("Veillez renseigner le Code Ventes");

        }


        return errors;
    }


}
