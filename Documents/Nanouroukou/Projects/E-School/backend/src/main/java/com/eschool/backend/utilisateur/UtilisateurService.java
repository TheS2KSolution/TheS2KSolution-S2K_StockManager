package com.eschool.backend.utilisateur;

import com.eschool.backend.Response.Response;
import jakarta.mail.MessagingException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional
public interface UtilisateurService {
    Response Inscription(UtilisateurDTO utilisateurDTO) throws MessagingException;
    Response activation(Map<String, String> code);
}
