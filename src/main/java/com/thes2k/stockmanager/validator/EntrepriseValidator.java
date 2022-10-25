package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.EntrepriseDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class EntrepriseValidator {
    public static List<String> validate(EntrepriseDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le nom de l'entreprise");
            errors.add("Veillez renseigner le CodeFiscal de l'entreprise ");
            errors.add("Veillez renseigner l'email de l'entreprise");
            errors.add("Veillez renseigner username de l'entreprise");
            errors.add("Veillez renseigner logo de l'entreprise");
            errors.add("Veillez renseigner password de l'entreprise");
            return errors;

        }
        if (!StringUtils.hasLength(dto.getEntrepriseName())) {
            errors.add("Veillez renseigner le nom de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getCodeFiscal())) {
            errors.add("Veillez renseigner le CodeFiscal de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getEntrepriseName())) {
            errors.add("Veillez renseigner le Nom de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getEmail())) {
            errors.add("Veillez renseigner l 'email de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getUsername())) {
            errors.add("Veillez renseigner username de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getPassword())) {
            errors.add("Veillez renseigner password de l'entreprise");

        }
        if (!StringUtils.hasLength(dto.getPhoto())) {
            errors.add("Veillez renseigner la photo de l'entreprise");

        }

        return errors;
    }
}
