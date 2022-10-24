package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class CategoryDto {
    private Integer id;
    private String codeCategory;
    private String designation;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}
