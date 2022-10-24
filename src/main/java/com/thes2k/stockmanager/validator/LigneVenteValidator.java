package com.thes2k.stockmanager.validator;


import com.thes2k.stockmanager.dto.LigneVenteDto;

import java.util.ArrayList;
import java.util.List;

public class LigneVenteValidator {
    public static List<String> validate(LigneVenteDto dto) {
        List<String> errors = new ArrayList<>();
        if (dto == null) {
            errors.add("Veillez renseigner Vente");
            errors.add("Veillez renseigner la Quantite ");
            return errors;

        }

        if (dto.getVentesDto() == null) {
            errors.add("Veillez renseigner la Vente");

        }


        return errors;
    }
}
