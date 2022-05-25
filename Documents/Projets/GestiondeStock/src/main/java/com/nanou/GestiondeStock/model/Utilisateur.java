package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.time.Instant;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "utilisateur ")
public class Utilisateur extends AbstractEntity {
    @Column(name = "nom")
    private String nom;
    @Column(name = "prenom")
    private String Prenom;
    @Column(name = "email")
    private String email;
    @Column(name = "datedenaissance")
    private Instant dateDeNaissance;
    @Column(name = "motdepasse")
    private String motDePasse;
    private String codeUtilisateur;
    @Embedded
    private Address address;
    @Column(name = "photo")
    private String photo;
    @OneToMany(mappedBy = "utilisateur")
    private List<Roles> roles;
    @ManyToOne
    private Entreprise entreprise;


}
