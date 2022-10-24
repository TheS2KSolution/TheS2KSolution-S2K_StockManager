package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class LigneCommandeFournisseur extends AbstractEntity {
    private String codeLigneCommandeFournisseur;
    private BigDecimal quantite;
    private BigDecimal prixUnitaire;
    @ManyToOne
    private Article article;
    @ManyToOne
    private CommandeFournisseur commandeFournisseur;

}
