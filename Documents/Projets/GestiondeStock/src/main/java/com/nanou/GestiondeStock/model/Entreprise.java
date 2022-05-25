package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.util.Collection;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Entreprise ")
public class Entreprise extends AbstractEntity {
    @Column(name = "nom")
    private String nom;
    @Column(name = "description")
    private String description;
    @Embedded
    private Address adresse;
    @Column(name = "photo")
    private String photo;
    @Column(name = "mail")
    private String mail;
    @Column(name = "codeFiscal")
    private String codeFiscal;
    @Column(name = "numTel")
    private String numTel;
    @Column(name = "steWeb")
    private String steWeb;
    private String codeEntreprise;
    @OneToMany(mappedBy = "entreprise")
    private Collection<Article> articles;
    @OneToMany(mappedBy = "entreprise")
    private List<Utilisateur> utilisateurs;

}
