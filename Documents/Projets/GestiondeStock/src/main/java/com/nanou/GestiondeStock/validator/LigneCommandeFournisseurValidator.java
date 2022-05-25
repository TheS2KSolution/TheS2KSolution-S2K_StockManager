package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.LigneCommandeFournisseurDto;

import java.util.ArrayList;
import java.util.List;

public class LigneCommandeFournisseurValidator {
    public static List<String> validate(LigneCommandeFournisseurDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code de la Commande du Fournisseur");
            return errors;
        }
        if (dto.getQuantite() == null) {
            errors.add("Veillez renseigner la Quantite Commande du Fournisseur");

        }
        return errors;
    }

}

