package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.math.BigDecimal;
import java.util.Collection;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Article extends AbstractEntity {
    private String codeArticle;
    private String designation;
    private BigDecimal prixUnitaire;
    private String photo;
    @ManyToOne
    private Entreprise entreprise;
    @ManyToOne
    private Category category;
    @OneToMany(mappedBy = "article")
    private Collection<MvtStk> mvtStks;
    @OneToMany(mappedBy = "article")
    private Collection<LigneVente> ligneVentes;
    @OneToMany(mappedBy = "article")
    private Collection<LigneCommandeClient> ligneCommandeClients;
    @OneToMany(mappedBy = "article")
    private Collection<LigneCommandeFournisseur> ligneCommandeFournisseurs;


}

