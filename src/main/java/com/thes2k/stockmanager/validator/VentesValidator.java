package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.VentesDto;
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


        if (!StringUtils.hasLength(dto.getCodeVentes())) {
            errors.add("Veillez renseigner le Code Ventes");

        }


        return errors;
    }


}
