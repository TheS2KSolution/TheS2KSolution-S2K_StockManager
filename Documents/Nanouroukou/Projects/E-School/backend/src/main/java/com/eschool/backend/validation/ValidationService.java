package com.eschool.backend.validation;

import com.eschool.backend.utilisateur.Utilisateur;
import jakarta.mail.MessagingException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public interface ValidationService {
    void enregistrer(Utilisateur utilisateur) throws MessagingException;
    Validation findValidationByCode(String code);
}
