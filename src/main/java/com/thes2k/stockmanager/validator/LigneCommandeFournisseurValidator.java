package com.thes2k.stockmanager.validator;

import com.thes2k.stockmanager.dto.LigneCommandeFournisseurDto;

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

