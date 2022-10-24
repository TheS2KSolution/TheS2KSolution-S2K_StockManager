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
public class LigneCommandeClient extends AbstractEntity {
    private String codeLigneCommandeClient;
    private BigDecimal Quantite;
    private BigDecimal prixUnitaire;
    @ManyToOne
    private Article article;
    @ManyToOne
    private CommandeClient commandeClient;

}
