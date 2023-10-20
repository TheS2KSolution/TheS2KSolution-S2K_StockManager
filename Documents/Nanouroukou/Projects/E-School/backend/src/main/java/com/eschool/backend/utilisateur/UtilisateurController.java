package com.eschool.backend.utilisateur;

import com.eschool.backend.Response.Response;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
public class UtilisateurController {

    private final UtilisateurService utilisateurService;

    @PostMapping(value = "" + "inscription")
    public Response inscription(@RequestBody UtilisateurDTO utilisateurDTO ) throws MessagingException {
        log.info("la requête a abouti ");
        return utilisateurService.Inscription(utilisateurDTO);

    }
    @PostMapping(value = "" + "activation")
    public Response activation (@RequestBody Map<String,String> activation){
        log.info("la requête a abouti ");
        return utilisateurService.activation(activation);
    }
}
