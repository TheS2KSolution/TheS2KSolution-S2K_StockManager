package com.thes2k.stockmanager.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Embeddable;
@Getter
@Setter
@Embeddable
public class Address {
    private String pays;
    private String Region;
    private String ville;
    private String commune;
    private String quartier;
}
