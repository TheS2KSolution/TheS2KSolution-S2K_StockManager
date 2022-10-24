package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class LigneCommandeClientDto {
    private Integer id;
    private String codeLigneCommandeClient;
    private BigDecimal Quantite;
    private BigDecimal prixUnitaire;
    private ArticleDto articleDto;
    private CommandeClientDto commandeClientDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
