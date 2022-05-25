package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.time.Instant;
import java.util.Collection;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "commandeFournisseur ")
public class CommandeFournisseur extends AbstractEntity {
    @Column(name = "code")
    private String code;
    @Column(name = "dateCommande")
    private Instant dateCommande;
    @OneToMany(mappedBy = "commandeFournisseur")
    private Collection<LigneCommandeFournisseur> ligneCommandeFournisseurs;
    @ManyToOne
    private Fournisseur fournisseur;

}
