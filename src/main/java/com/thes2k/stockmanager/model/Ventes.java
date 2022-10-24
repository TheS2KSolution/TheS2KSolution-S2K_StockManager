package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import java.time.Instant;
import java.util.Collection;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity

public class Ventes extends AbstractEntity {
    private String codeVentes;
    private Instant dateVente;
    private String commentaire;
    @OneToMany(mappedBy = "ventes")
    private Collection<LigneVente> ligneVentes;


}
