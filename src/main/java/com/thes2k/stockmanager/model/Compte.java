package com.thes2k.stockmanager.model;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="type", length = 12, discriminatorType = DiscriminatorType.STRING)
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(name = "SUPER_ADMIN", value = SuperAdmin.class),
        @JsonSubTypes.Type(name = "UTILISATEUR", value = Utilisateur.class),
        @JsonSubTypes.Type(name = "ENTREPRISE", value = Entreprise.class)
})

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public  class  Compte {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String fullName;
    @Column(unique = true,nullable = false)
    private String email;
    @Column(unique = true, nullable = false)
    private String username;
    @Column(nullable = false)
    private String password;
    @Column(unique = true, nullable = false)
    private String phone;
    @Embedded
    private Address address;
    private String photo;
    private Etat_Compte etatCompte = Etat_Compte.DESACTIVER;
    @Column(nullable = false, updatable = false)
    private LocalDateTime creationDate = LocalDateTime.now();
    private LocalDate lastModifiedDate;
    @ManyToMany(fetch = FetchType.EAGER)
    private Set<Roles> roles = new HashSet<>();

}
