package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.time.Instant;
import java.util.Collection;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class CommandeFournisseur extends AbstractEntity {
    private String codeCommandeFournisseur;
    private Instant dateCommandeFournisseur;
    @OneToMany(mappedBy = "commandeFournisseur")
    private Collection<LigneCommandeFournisseur> ligneCommandeFournisseurs;
    @ManyToOne
    private Fournisseur fournisseur;

}
