package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Collection;


@Getter
@Setter
public class CommandeFournisseurDto {
    private Integer id;
    private String codeCommandeFournisseur;
    private Instant dateCommandeFournisseur;
    private FournisseurDto fournisseurDto;
    private Collection<LigneCommandeFournisseurDto> ligneCommandeFournisseurDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
