package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import java.util.Collection;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Fournisseur extends AbstractEntity {
    private String codeFournisseur;
    @Embedded
    private Address adresse;
    private String nom;
    private String prenom;
    private String email;
    private Integer phone;
    @OneToMany(mappedBy = "fournisseur")
    private Collection<CommandeFournisseur> commandeFournisseurs;

}

