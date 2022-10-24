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
public class CommandeClient extends AbstractEntity {
    private String codeCommandeClient;
    private Instant dateCommande;
    private EtatCommande etatcommande;
    @ManyToOne
    private Client client;
    @OneToMany(mappedBy = "commandeClient")
    private Collection<LigneCommandeClient> ligneCommandeClients;


}

