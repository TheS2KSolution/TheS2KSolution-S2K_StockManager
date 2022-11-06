package com.thes2k.stockmanager.dto;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
public class UtilisateurDto extends CompteDto {
    private String type;
    private String fullName;
    private String phone;
    private String email;
    private String username;
    private String password;
    private String photo;
    private List<RolesDto> rolesDtos;
    private AddressDto addressDto;
    private Etat_CompteDto etat_compteDto = Etat_CompteDto.DESACTIVER;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
    private Set<RolesDto> rolesDto = new HashSet<>();

}
