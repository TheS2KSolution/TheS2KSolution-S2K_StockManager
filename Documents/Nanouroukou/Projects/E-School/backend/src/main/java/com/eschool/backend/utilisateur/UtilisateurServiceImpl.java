package com.eschool.backend.utilisateur;

import com.eschool.backend.Exception.ExistException;
import com.eschool.backend.Exception.InvalidEntityException;
import com.eschool.backend.Notification.MailSender;
import com.eschool.backend.Role.*;
import com.eschool.backend.Response.Response;
import com.eschool.backend.validation.Validation;
import com.eschool.backend.validation.ValidationMapper;
import com.eschool.backend.validation.ValidationService;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;

import static com.eschool.backend.Response.Message.*;

@RequiredArgsConstructor
@Service
public class UtilisateurServiceImpl implements UtilisateurService {

    private final UtilisateurRepository utilisateurRepository;
    private final RoleRepository roleRepository;
    private final UtilisateurMapper utilisateurMapper;
    private final BCryptPasswordEncoder passwordEncoder;
    private final ValidationService validationService;
    private final ValidationMapper validationMapper;
    private final RoleMapper roleMapper;
    private final MailSender mailSender;
    @Override
    public Response Inscription(UtilisateurDTO utilisateurDTO) throws MessagingException {
        if (!utilisateurDTO.getEmail().contains("@")|| !utilisateurDTO.getEmail().contains(".") ){
            throw new InvalidEntityException(NO,EMAIL_INVALID);
        }
        Optional<Utilisateur> userByEmail = utilisateurRepository.findUserByEmail(utilisateurDTO.getEmail());
        if (userByEmail.isPresent()){
            throw new ExistException(NO,EMAIL_ALREADY_EXIST);
        }
        Role role = new Role();
        role.setRoleType(RoleType.USER);
        Utilisateur utilisateur = utilisateurMapper.toEntity(utilisateurDTO);
        utilisateur.setRole(role);
        System.out.println("le roles est "+utilisateur.getRole());
        utilisateur.setPassword(passwordEncoder.encode(utilisateurDTO.getPassword()));
        Utilisateur save = utilisateurRepository.save(utilisateur);
        validationService.enregistrer(save);
        return  new Response(OK,USERNAME_SUCCESS_SAVE);
    }

    @Override
    public Response activation(Map<String, String> activation) {
        Validation validation = validationService.findValidationByCode(activation.get("code"));
        Utilisateur utilisateur = utilisateurRepository.findById(validation.getUtilisateur().getId()).orElseThrow(() -> new InvalidEntityException(NO,USER_INVALID));

        if (Instant.now().isAfter(validation.getExpireDate())){
            throw new ExistException(NO,Code_ALREADY_EXIP);
        }
        else
            if (utilisateur.isActive() && Instant.now().isBefore(validation.getExpireDate())){
            throw new ExistException(NO,Code_ALREADY_USED);
        }


          utilisateur.setActive(true);


        utilisateurRepository.save(utilisateur);
        return new Response(OK,USERNAME_SUCCESS_ACTIVED);
    }

}
