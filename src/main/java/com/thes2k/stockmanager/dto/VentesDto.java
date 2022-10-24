package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Collection;

@Getter
@Setter
public class VentesDto {
    private Integer id;
    private String codeVentes;
    private Instant dateVente;
    private String commentaire;
    private Collection<LigneVenteDto> ligneVentesDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
