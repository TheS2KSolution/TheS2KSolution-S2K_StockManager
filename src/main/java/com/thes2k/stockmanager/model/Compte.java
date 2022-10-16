package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Compte {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column( nullable = false, updatable = false)
    private LocalDate creationDate = LocalDate.now() ;
    private LocalDate lastModifiedDate;
    private String fullName;
    @Column(unique = true,nullable = false)
    private String email;
    @Column(unique = true,nullable = false)
    private String username;
    @Column(nullable = false)
    private String password;
    @Column(unique = true,nullable = false)
    private String phone;
    @Embedded
    private Address address;
    private String photo;
    private Etat etat = Etat.DESACTIVER;

}
