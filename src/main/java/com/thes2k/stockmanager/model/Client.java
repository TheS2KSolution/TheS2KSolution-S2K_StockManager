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
public class Client extends AbstractEntity {
    private String codeClient;
    private String nom;
    private String prenom;
    private String email;
    private String phone;
    @Embedded
    private Address adresse;
    @OneToMany(mappedBy = "client")
    private Collection<CommandeClient> commandeClients;

}
