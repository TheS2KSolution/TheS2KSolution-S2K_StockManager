package com.nanou.fullbackend.domain;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false,updatable = false)
    private Long id;
    private String userId;
    private String firstName;
    private String lastName;
    @Column(nullable = false,updatable = false)
    private String username;
    private String password;
    @Column(nullable = false,updatable = false)
    private String email;
    private String profileImage;
    private Date lastLoginDate;
    private Date lastLoginDateDisplay;
    private Date joinDate;
    private String  role; // ROLES_USER{read,edit},ROLE_ADMIN{delete}
    private String []authorities;
    private boolean isActive;
    private boolean isNotLocked;



}
