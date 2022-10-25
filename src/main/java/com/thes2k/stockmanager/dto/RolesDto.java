package com.thes2k.stockmanager.dto;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class RolesDto {
    private Integer id;
    private String roleName;
    private CompteDto compteDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
