package com.thes2k.stockmanager.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddressDto {
    private String pays;
    private String Region;
    private String ville;
    private String commune;
    private String quartier;
    private Integer telephone;
}
