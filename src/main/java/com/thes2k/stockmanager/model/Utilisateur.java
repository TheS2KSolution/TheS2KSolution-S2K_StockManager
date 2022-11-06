package com.thes2k.stockmanager.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("UTILISATEUR")
@Setter
@Getter
public class Utilisateur extends Compte {
}
