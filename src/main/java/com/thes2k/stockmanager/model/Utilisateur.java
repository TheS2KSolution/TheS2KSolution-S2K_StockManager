package com.thes2k.stockmanager.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("UTILISATEUR")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Utilisateur extends Compte{
    private String codeUtilisateur;
}
