package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.time.Instant;
import java.util.Collection;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Ventes ")
public class Ventes extends AbstractEntity {
    @Column(name = "code")
    private String code;
    @Column(name = "dateVente")
    private Instant dateVente;
    @Column(name = "commentaire")
    private String commentaire;
    @OneToMany(mappedBy = "ventes")
    private Collection<LigneVente> ligneVentes;


}
