package com.thes2k.stockmanager.dto;


import lombok.Data;

import java.time.LocalDate;

@Data
public class UtilisateurDto {
    private Integer id;
    private String codeUtilisateur;
    private String email;
    private String username;
    private String password;
    private String phone;
    private AddressDto addressDto;
    private String photo;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
