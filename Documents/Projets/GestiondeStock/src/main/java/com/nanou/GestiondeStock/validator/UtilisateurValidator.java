package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.UtilisateurDto;
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
            errors.add("Veillez renseigner l'Adresse Utilisateur");
            errors.add("Veillez renseigner le mail");
            return errors;
        }
        if (!StringUtils.hasLength(utilisateurDto.getNom())) {
            errors.add("Veillez renseigner le nom Utilisateur");

        }


        if (!StringUtils.hasLength(utilisateurDto.getPrenom())) {
            errors.add("Veillez renseigner le prenom Utilisateur");

        }
        if (!StringUtils.hasLength(utilisateurDto.getEmail())) {
            errors.add("Veillez renseigner le mail");

        }
        if (!StringUtils.hasLength(utilisateurDto.getMotDePasse())) {
            errors.add("Veillez renseigner le mot de passe");

        }
        if (utilisateurDto.getAdresses() == null) {
            errors.add("Veillez renseigner l'Adresse Utilisateur");

        } else {
            if (!StringUtils.hasLength(utilisateurDto.getAdresses().getAdresse1())) {
                errors.add("Le champs 'adresse1' est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAdresses().getVille())) {
                errors.add("Le champs 'Ville' est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAdresses().getCodePostale())) {
                errors.add("Le champs 'Code postale' est Obligatoire");

            }
            if (!StringUtils.hasLength(utilisateurDto.getAdresses().getPays())) {
                errors.add("Le champs 'Pays' est Obligatoire");

            }
        }
        return errors;
    }


}






