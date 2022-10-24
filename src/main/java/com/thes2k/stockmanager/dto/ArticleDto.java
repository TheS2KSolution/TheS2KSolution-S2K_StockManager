package com.thes2k.stockmanager.dto;


import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collection;

@Getter
@Setter
public class ArticleDto {
    private Integer id;
    private String codeArticle;
    private String designation;
    private BigDecimal prixUnitaire;
    private String photo;
    private EntrepriseDto entrepriseDto;
    private CategoryDto categoryDto;
    private Collection<MvtStkDto> mvtStksDto;
    private Collection<LigneVenteDto> ligneVentesDto;
    private Collection<LigneCommandeClientDto> ligneCommandeClientsDto;
    private Collection<LigneCommandeFournisseurDto> ligneCommandeFournisseursDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
