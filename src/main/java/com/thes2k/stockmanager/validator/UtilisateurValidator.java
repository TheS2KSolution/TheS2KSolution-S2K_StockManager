package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.UtilisateurDto;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class UtilisateurValidator {
    public static List<String> validate(UtilisateurDto utilisateurDto) {
        List<String> errors = new ArrayList<>();
        if (utilisateurDto == null) {
            errors.add("Veillez renseigner le prenom Utilisateur");
            errors.add("Veillez renseigner le nom Utilisateur");
            errors.add("Veillez renseigner le mot de passe");
            errors.add("Veillez renseigner l'username'");
            errors.add("Veillez renseigner l'Adresse Utilisateur");
            errors.add("Veillez renseigner le mail");
            return errors;
        }
        if (!StringUtils.hasLength(utilisateurDto.getFullName())) {
            errors.add("Veillez renseigner le nom Utilisateur");

        }


        if (!StringUtils.hasLength(utilisateurDto.getEmail())) {
            errors.add("Veillez renseigner le mail");

        }
        if (!StringUtils.hasLength(utilisateurDto.getPassword())) {
            errors.add("Veillez renseigner le mot de passe");

        }
        if (!StringUtils.hasLength(utilisateurDto.getUsername())) {
            errors.add("Veillez renseigner le mot de passe");

        }
        if (!StringUtils.hasLength(utilisateurDto.getPassword())) {
            errors.add("Veillez renseigner le mot de passe");

        }
        /*if (utilisateurDto.getAddressDto() == null) {
            errors.add("Veillez renseigner l'Adresse Utilisateur");

        } else {
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getVille())) {
                errors.add("Le champs ville est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getPays())) {
                errors.add("Le champs pays est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getCommune())) {
                errors.add("Le champs commune est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getQuartier())) {
                errors.add("Le champs quartier est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getRegion())) {
                errors.add("Le champs region est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAddressDto().getTelephone())) {
                errors.add("Le champs Telephone est Obligatoire");

            }*/
        //}
        return errors;
    }


}






