package com.nanou.GestiondeStock.validator;

import com.nanou.GestiondeStock.dto.MvtStkDto;

import java.util.ArrayList;
import java.util.List;

public class MvtStkValidator {
    public static List<String> validate(MvtStkDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code de la Commande du Client");
            errors.add("Veillez renseigner la Quantite Commande du Client");
            return errors;
        }
        if (dto.getArticle() == null) {
            errors.add("Veillez renseigner le Code de la Commande du Client");

        }
        if (dto.getQuantite() == null) {
            errors.add("Veillez renseigner la Quantite Commande du Fournisseur");

        }

        return errors;
    }


}
