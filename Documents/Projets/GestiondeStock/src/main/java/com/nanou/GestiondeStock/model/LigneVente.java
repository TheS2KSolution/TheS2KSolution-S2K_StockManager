package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ligneVente ")
public class LigneVente extends AbstractEntity {
    @Column(name = "quantite")
    private BigDecimal Quantite;
    @Column(name = "prixUnitaire")
    private BigDecimal prixUnitaire;
    @ManyToOne
    private Article article;
    @ManyToOne
    private Ventes ventes;


}
