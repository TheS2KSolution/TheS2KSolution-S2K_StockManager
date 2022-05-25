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
@Table(name = "client ")

public class Client extends AbstractEntity {
    @Column(name = "nom")
    private String nom;
    @Column(name = "prenom")
    private String prenom;
    @Embedded
    private Address adresse;
    @Column(name = "photo")
    private String photo;
    @Column(name = "mail")
    private String mail;
    @Column(name = "numTel")
    private String numTel;
    private String codeClient;
    @OneToMany(mappedBy = "client")
    private Collection<CommandeClient> commandeClients;

}
