package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.CompteDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class CompteValidator {
    public static List<String> validate(CompteDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le champ fullName ");
            errors.add("Veillez renseigner le champ email ");
            errors.add("Veillez renseigner  le champ username ");
            errors.add("Veillez renseigner le champ password ");
            errors.add("Veillez renseigner le champ phone ");
            errors.add("Veillez renseigner le champ Addresse ");
            errors.add("Veillez renseigner le champ Mot de passe ");

            return errors;
        }
//        if (!StringUtils.hasLength(dto.getNom())) {
//            errors.add("Veillez renseigner le nom ");
//
//        }
       /* if (!StringUtils.hasLength(dto.getPrenom())) {
            errors.add("Veillez renseigner le Prenom ");

        }*/
        if (!StringUtils.hasLength(dto.getEmail())) {
            errors.add("Veillez renseigner le Mail ");

        }

        if (!StringUtils.hasLength(dto.getUsername())) {
            errors.add("Veillez renseigner le Login");

        }
        if (!StringUtils.hasLength(dto.getPassword())) {
            errors.add("Veillez renseigner le Mot de passe ");

        }
       /* if (!StringUtils.hasLength((CharSequence) dto.getAddressDto())) {
            errors.add("Veillez renseigner l'Adresse");

        }*/

        return errors;
    }
}
