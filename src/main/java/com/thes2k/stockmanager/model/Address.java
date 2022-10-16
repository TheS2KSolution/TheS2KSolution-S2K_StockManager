package com.thes2k.stockmanager.model;

import javax.persistence.Embeddable;

@Embeddable
public class Address {
    private String pays;
    private String Region;
    private String ville;
    private String commune;
    private String quartier;
}
