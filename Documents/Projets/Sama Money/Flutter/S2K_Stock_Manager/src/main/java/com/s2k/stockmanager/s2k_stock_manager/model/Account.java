package com.s2k.stockmanager.s2k_stock_manager.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;

@Data
@EqualsAndHashCode(callSuper = true)
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class Account extends AbstractEntity {
    @Column(name = "usercode")
    private String codeUser;
    @Column(name = "nom")
    private String nom;
    @Column(name = "prenom")
    private String Prenom;
    @Column(name = "email")
    private String email;
    @Column(name = "motdepasse")
    private String motDePasse;
    @Embedded
    private Address address;
    @Column(name = "photo")
    private String photo;

}
