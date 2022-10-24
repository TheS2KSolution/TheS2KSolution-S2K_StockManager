package com.thes2k.stockmanager.validator;


import com.thes2k.stockmanager.dto.LigneCommandeClientDto;

import java.util.ArrayList;
import java.util.List;

public class LigneCommandeClientValidator {
    public static List<String> validate(LigneCommandeClientDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner le Code de la Commande du Client");
            errors.add("Veillez renseigner la Quantite Commande du Client");
            return errors;
        }
        if (dto.getArticleDto() == null) {
            errors.add("Veillez renseigner le Code de la Commande du Client");

        }
        if (dto.getQuantite() == null) {
            errors.add("Veillez renseigner la Quantite Commande du Fournisseur");

        }

        return errors;
    }

}

