package com.eschool.backend.validation;
import com.eschool.backend.Exception.InvalidEntityException;
import com.eschool.backend.Notification.MailSender;
import com.eschool.backend.utilisateur.Utilisateur;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Random;

import static com.eschool.backend.Response.Message.CODE_INVALID;
import static com.eschool.backend.Response.Message.NO;

@RequiredArgsConstructor
@Service
public class ValidationServiceImpl implements ValidationService {
    private final ValidationRepository validationRepository;
    private final MailSender mailSender;



    @Override
    public void  enregistrer(Utilisateur utilisateur) throws MessagingException {
        Validation validation = new Validation();
        validation.setUtilisateur(utilisateur);
        Instant creationDate =Instant.now();
        Instant expirationDate =creationDate.plus(10, ChronoUnit.MINUTES);
        Random random = new Random();
        int randomInteger = random.nextInt(999999);
        String code =String.format("%06d",randomInteger);
        validation.setCreationDate(creationDate);
        validation.setExpireDate(expirationDate);
        validation.setCode(code);
        validationRepository.save(validation);
        mailSender.sendMessage(validation.getUtilisateur().getEmail(), validation.getCode(),"activation-email");


    }

    @Override
    public Validation findValidationByCode (String code) {
       return validationRepository.findValidationByCode(code).orElseThrow(()-> new InvalidEntityException(NO,CODE_INVALID));
    }
}
