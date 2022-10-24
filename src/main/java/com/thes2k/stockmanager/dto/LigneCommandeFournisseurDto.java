package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class LigneCommandeFournisseurDto {
    private Integer id;
    private String codeLigneCommandeFournisseur;
    private BigDecimal Quantite;
    private BigDecimal prixUnitaire;
    private ArticleDto articleDto;
    private CommandeFournisseurDto commandeFournisseurDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
