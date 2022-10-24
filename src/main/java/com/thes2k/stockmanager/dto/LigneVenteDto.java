package com.thes2k.stockmanager.dto;


import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class LigneVenteDto {
    private Integer id;
    private String codeLigneVente;
    private BigDecimal Quantite;
    private BigDecimal prixUnitaire;
    private ArticleDto articleDto;
    private VentesDto ventesDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}

