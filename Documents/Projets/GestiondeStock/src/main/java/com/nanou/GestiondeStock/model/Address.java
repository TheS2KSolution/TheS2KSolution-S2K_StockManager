package com.nanou.GestiondeStock.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.Table;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
@Table(name = "client ")

public class Address {
    @Column(name = "identreprise")
    private Integer identreprise;
    @Column(name = "adresse1")
    private String adresse1;
    @Column(name = "adresse2")
    private String adresse2;
    @Column(name = "ville")
    private String ville;
    @Column(name = "codePostale")
    private String codePostale;
    @Column(name = "pays")
    private String pays;

}
