package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "article ")
public class Article extends AbstractEntity {
    @Column(name = "codearticle")
    private String codeArticle;
    @Column(name = "designation")
    private String designation;
    @Column(name = "prixUnitaireht")
    private BigDecimal prixUnitaireht;
    @Column(name = "tauxTva")
    private BigDecimal tauxTva;
    @Column(name = "prixUnitairettc")
    private BigDecimal prixUnitaireTtc;
    @Column(name = "photo")
    private String photo;
    @Column(name = "identreprise")
    private Integer idEntreprise;
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

