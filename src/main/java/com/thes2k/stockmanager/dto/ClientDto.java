package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Collection;

@Getter
@Setter
public class ClientDto {
    private Integer id;
    private String nom;
    private String prenom;
    private String email;
    private Integer telephone;
    private String codeClient;
    private AddressDto addressDto;
    private Collection<CommandeClientDto> commandeClientDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
