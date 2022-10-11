package com.s2k.stockmanager.s2k_stock_manager.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
@Table(name = "address ")
public class Address {
    @Column(name = "ville")
    private String ville;
    @Column(name = "quartier")
    private String quartier;
    @Column(name = "teléphone")
    private String teléphone;
    @Column(name = "codePostale")
    private String codePostale;
    @Column(name = "pays")
    private String pays;

}
