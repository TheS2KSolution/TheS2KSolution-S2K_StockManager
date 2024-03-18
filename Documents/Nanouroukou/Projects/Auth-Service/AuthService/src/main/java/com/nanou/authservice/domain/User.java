package com.nanou.authservice.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.nanou.authservice.enumeration.enums.AccountStatus;
import com.nanou.authservice.enumeration.enums.Gender;
import com.nanou.authservice.enumeration.role.UserRoles;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class User implements Serializable {
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false, updatable = false)
    @Id
    private String id;
    private String userId;
    private String firstName;
    private String lastName;
    @Column(unique = true)
    private String username;
    @Column(unique = true)
    private String email;
    private String phone;
    private String photoFileName;
    private boolean emailVerified;
    private String photoURL;
    private String temporaryActivationCode;
    private Instant temporaryActivationCodeTimeStamp;
    private Date lastLoginDate;
    private Date lastLoginDateDisplay;
    private Date joinDate;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    @Enumerated(EnumType.STRING)
    private AccountStatus status;
    @Enumerated(EnumType.STRING)
    private UserRoles userRoles;
    private boolean isActive;
    private boolean isNotLocked;
    @ElementCollection
    private List<String> requestedRoles = new ArrayList<>();
    @ManyToOne
    private Role role;

}

