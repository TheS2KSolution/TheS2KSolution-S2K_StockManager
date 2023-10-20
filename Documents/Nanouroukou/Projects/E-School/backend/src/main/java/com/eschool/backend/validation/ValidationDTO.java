package com.eschool.backend.validation;


import com.eschool.backend.utilisateur.UtilisateurDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ValidationDTO {
    private Long id;
    private Instant creationDate;
    private Instant activationDate;
    private Instant expireDate;
    private String Code;
    private UtilisateurDTO utilisateurDTO;

}
