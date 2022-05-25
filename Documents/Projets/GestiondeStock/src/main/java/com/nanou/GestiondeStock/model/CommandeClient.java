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
@Table(name = "commandeClient ")
public class CommandeClient extends AbstractEntity {
    @Column(name = "code")
    private String code;
    @Column(name = "datecommande")
    private Instant dateCommande;

    private  EtatCommande etatcommande;
    private Integer idEntreprise;
    @ManyToOne
    private Client client;
    @OneToMany(mappedBy = "commandeClient")
    private Collection<LigneCommandeClient> ligneCommandeClients;


}

