package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class EntrepriseDto extends CompteDto {
    private Integer id;
    private String entrepriseName;
    private String codeFiscal;
    private String email;
    private String username;
    private String password;
    private String phone;
    private AddressDto addressDto;
    private String photo;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;

}
