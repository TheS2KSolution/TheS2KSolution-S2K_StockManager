package com.thes2k.stockmanager.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("superAdmin")
@AllArgsConstructor
public class SuperAdmin extends  Compte {

}
