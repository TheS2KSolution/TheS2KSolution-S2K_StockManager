package com.thes2k.stockmanager.dto;


import com.thes2k.stockmanager.model.Address;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
public class CompteDto  {
    private String type;
    private String fullName;
    private String phone;
    private String email;
    private String username;
    private String password;
    private String photo;
    private List<RolesDto> rolesDtos;
    private Address address;
    private Etat_CompteDto etat_compteDto = Etat_CompteDto.DESACTIVER;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
    private Set<RolesDto> rolesDto = new HashSet<>();


}
