package com.thes2k.stockmanager.dto;

import com.thes2k.stockmanager.model.EtatCommande;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Collection;


@Getter
@Setter
public class CommandeClientDto {
    private Integer id;
    private String codeCommandeClient;
    private Instant dateCommande;
    private EtatCommande etatcommande;
    private ClientDto clientDto;
    private Collection<LigneCommandeClientDto> ligneCommandeClientDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
