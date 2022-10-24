package com.thes2k.stockmanager.dto;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Collection;

@Getter
@Setter
public class FournisseurDto {
    private Integer id;
    private AddressDto adresseDto;
    private String nom;
    private String prenom;
    private String email;
    private String telephone;
    private String codeFournisseur;
    private Collection<CommandeFournisseurDto> commandeFournisseurDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
