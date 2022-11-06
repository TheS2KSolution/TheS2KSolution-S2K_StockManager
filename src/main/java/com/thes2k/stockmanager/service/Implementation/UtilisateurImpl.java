package com.thes2k.stockmanager.service.Implementation;

import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.exception.EntityNotFoundException;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.mapper.UtilisateurMapper;
import com.thes2k.stockmanager.model.Etat_Compte;
import com.thes2k.stockmanager.model.Utilisateur;
import com.thes2k.stockmanager.repository.UtilisateurRepository;
import com.thes2k.stockmanager.service.feature.UtilisateurService;
import com.thes2k.stockmanager.validator.UtilisateurValidator;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class UtilisateurImpl implements UtilisateurService {
    private final UtilisateurRepository utilisateurRepository;
    private final UtilisateurMapper utilisateurMapper;
    Response response = new Response();

    @Override
    public Response save(UtilisateurDto utilisateurDto) {
        boolean isCompteExists = checkIfCompteExists(utilisateurDto.getUsername(), utilisateurDto.getEmail(), utilisateurDto.getPhone());
        Utilisateur utilisateur = utilisateurMapper.fromEntity(utilisateurDto);
        List<String> errors = UtilisateurValidator.validate(utilisateurDto);
        if (!errors.isEmpty()) {
            throw new InvalidEntityException(-1, "Merci de bien verifier vos informations", errors);
        } else if (!isCompteExists) {
            response.setStatus(0);
            response.setMsg("ce compte existe déja ");
        } else {
            Utilisateur savedUtilisateur = utilisateurRepository.save(utilisateur);
            utilisateurMapper.toEntity(savedUtilisateur);
            response.setStatus(1);
            response.setMsg("Utilisateur Enregistré avec succes");
            response.setResult(utilisateurMapper.toEntity(utilisateur));
        }
        return response;
    }

    @Override
    public UtilisateurDto finById(Long id) {
        if (id == null) {
            log.error("Entreprise ID est nul");
            return null;
        }
        Utilisateur utilisateur = utilisateurRepository.findById(id).orElseThrow(() ->
                new EntityNotFoundException(0, "Aucun resultat trouvé avec cet id:" + id));
        return utilisateurMapper.toEntity(utilisateur);
    }


    @Override
    public List<UtilisateurDto> findAll() {
        return null;
    }

    @Override
    public Response delete(Long id) {

        if (id == null) {
            response.setStatus(0);
            response.setMsg("aucun article n'appartient a ce id:" + id);
        } else {
            Utilisateur deleteUtilisateur = utilisateurRepository.findById(id).orElseThrow();
            deleteUtilisateur.setEtatCompte(Etat_Compte.SUPPRIMER);
            utilisateurRepository.save(deleteUtilisateur);
            response.setStatus(1);
            response.setMsg("Article supprimé avec succes");
        }
        return response;
    }


    @Override
    public Response update(UtilisateurDto utilisateurDto) {
        boolean isCompteExists = checkIfCompteExists(utilisateurDto.getUsername(), utilisateurDto.getEmail(), utilisateurDto.getPhone());
        Utilisateur utilisateur = utilisateurMapper.fromEntity(utilisateurDto);
        List<String> errors = UtilisateurValidator.validate(utilisateurDto);
        if (!errors.isEmpty()) {
            throw new InvalidEntityException(-1, "Merci de bien verifier vos informations", errors);
        } else if (!isCompteExists) {
            response.setStatus(0);
            response.setMsg("ce compte existe déja ");
        } else {
            Utilisateur savedUtilisateur = utilisateurRepository.save(utilisateur);
            utilisateurMapper.toEntity(savedUtilisateur);
            response.setStatus(1);
            response.setMsg("Utilisateur modifié avec succes");
            response.setResult(utilisateurMapper.toEntity(utilisateur));
        }
        return response;
    }

    public boolean checkIfCompteExists(String username, String email, String phone) {
        Utilisateur existUsername = utilisateurRepository.findByUsername(username);
        Utilisateur existEmail = utilisateurRepository.findByEmail(email);
        Utilisateur existPhone = utilisateurRepository.findByPhone(phone);
        return existEmail == null && existUsername == null && existPhone == null;

    }
}
