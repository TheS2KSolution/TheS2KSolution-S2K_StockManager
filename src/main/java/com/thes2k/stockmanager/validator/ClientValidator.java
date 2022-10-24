package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.ClientDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class ClientValidator {
    public static List<String> validate(ClientDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le nom Client");
            errors.add("Veillez renseigner lePrenom Client");
            errors.add("Veillez renseigner le Mail Client");
            errors.add("Veillez renseigner le numero de telephone du Client");
            return errors;
        }
        if (!StringUtils.hasLength(dto.getNom())) {
            errors.add("Veillez renseigner le nom Client");

        }
        if (!StringUtils.hasLength(dto.getPrenom())) {
            errors.add("Veillez renseigner lePrenom Client");

        }
        if (!StringUtils.hasLength(dto.getEmail())) {
            errors.add("Veillez renseigner le Mail Client");

        }
        if (!StringUtils.hasLength(String.valueOf(dto.getTelephone()))) {
            errors.add("Veillez renseigner le numero de telephone du Client");

        }

        return errors;
    }
}
