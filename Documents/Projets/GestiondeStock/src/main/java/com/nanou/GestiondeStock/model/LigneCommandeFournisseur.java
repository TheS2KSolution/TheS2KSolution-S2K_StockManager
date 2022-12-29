package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "lignecommandeFournisseur ")
public class LigneCommandeFournisseur extends AbstractEntity {
    @Column(name = "Quantite")
    private BigDecimal Quantite;
    @Column(name = "prixUnitaire")
    private BigDecimal prixUnitaire;
    @ManyToOne
    private Article article;
    @ManyToOne
    private CommandeFournisseur commandeFournisseur;

}