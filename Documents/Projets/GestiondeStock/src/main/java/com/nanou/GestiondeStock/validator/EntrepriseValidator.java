package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.EntrepriseDto;

import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class EntrepriseValidator {
    public static List<String> validate(EntrepriseDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le nom de L entreprise");
            errors.add("Veillez renseigner le CodeFiscal");
            errors.add("Veillez renseigner le Mail de l entreprise");
            errors.add("Veillez renseigner le numero de telephone de l entreprise");
            errors.add("Veillez renseigner le Site Web entreprise");

        }
        if (!StringUtils.hasLength(dto.getNom())) {
            errors.add("Veillez renseigner le nom de L entreprise");

        }
        if (!StringUtils.hasLength(dto.getCodeFiscal())) {
            errors.add("Veillez renseigner le CodeFiscal");

        }
        if (!StringUtils.hasLength(dto.getMail())) {
            errors.add("Veillez renseigner le Mail de l entreprise");

        }
        if (!StringUtils.hasLength(dto.getNumTel())) {
            errors.add("Veillez renseigner le numero de telephone de l entreprise");

        }
        if (!StringUtils.hasLength(dto.getSteWeb())) {
            errors.add("Veillez renseigner le Site Web entreprise");

        }
        return errors;
    }
}
