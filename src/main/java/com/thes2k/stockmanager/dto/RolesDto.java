package com.thes2k.stockmanager.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class RolesDto {
    private Integer id;
    private String roleName;
    private CompteDto compteDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
