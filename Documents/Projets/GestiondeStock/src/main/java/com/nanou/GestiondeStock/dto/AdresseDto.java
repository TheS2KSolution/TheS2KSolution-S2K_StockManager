package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Address;
import lombok.Builder;
import lombok.Data;

import javax.persistence.Column;

@Builder
@Data
public class AdresseDto {

    private String adresse1;

    private String adresse2;

    private String ville;

    private String codePostale;

    private String pays;

    public AdresseDto fromEntity(Address adresse) {
        if (adresse == null) {
            return null;
        }
        return AdresseDto.builder()
                .adresse1(adresse.getAdresse1())
                .adresse2(adresse.getAdresse2())
                .codePostale(adresse.getCodePostale())
                .ville(adresse.getVille())
                .pays(adresse.getPays())
                .build();
    }

    public Address toEntity(AdresseDto adresseDto) {
        if (adresseDto == null) {
            return null;
        }
        Address adresse = new Address();
        adresse.setAdresse1(adresseDto.getAdresse1());
        adresse.setAdresse2(adresseDto.getAdresse2());
        adresse.setCodePostale(adresseDto.getCodePostale());
        adresse.setPays(adresseDto.getPays());
        adresse.setVille(adresseDto.getPays());
        return adresse;
    }
}
