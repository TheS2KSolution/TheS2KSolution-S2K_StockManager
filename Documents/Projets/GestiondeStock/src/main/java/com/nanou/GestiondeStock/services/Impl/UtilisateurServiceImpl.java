package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.UtilisateurDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Utilisateur;
import com.nanou.GestiondeStock.repository.UtilisateurRepository;
import com.nanou.GestiondeStock.services.UtilisateurService;
import com.nanou.GestiondeStock.validator.UtilisateurValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class UtilisateurServiceImpl implements UtilisateurService {

    private UtilisateurRepository utilisateurRepository;

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepository) {
        this.utilisateurRepository = utilisateurRepository;

    }

    @Override
    public UtilisateurDto save(UtilisateurDto dto) {
        List<String> errors = UtilisateurValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("utilisateur n est pas valide{}", dto);
            throw new InvalidEntityException("L utilisateur n est pas valide", ErrorCodes.ARTICLE_NOT_VALID, errors);
        }
        return UtilisateurDto.fromEntity(utilisateurRepository.save(
                UtilisateurDto.toEntity(dto)
        ));
    }

    @Override
    public UtilisateurDto findByCodeUtilisateur(String codeUtilisateur) {
        if (!StringUtils.hasLength(codeUtilisateur)) {
            log.error("Utilisateur Code est nul");
            return null;
        }
        Optional<Utilisateur> utilisateur = utilisateurRepository.findCategoryByCodeUtilisateur(codeUtilisateur);

        return Optional.of(UtilisateurDto.fromEntity(utilisateur.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun Utilisateur avec le CODE =" + codeUtilisateur + "n'ete trouve dans la Base",
                        ErrorCodes.UTILISATEUR_NOT_FOUND)

        );
    }

    @Override
    public UtilisateurDto finById(Integer id) {
        if (id == null) {
            log.error("utilisateur ID est nul");
            return null;
        }
        Optional<Utilisateur> utilisateur = utilisateurRepository.findById(id);

        return Optional.of(UtilisateurDto.fromEntity(utilisateur.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun utilisateur avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.UTILISATEUR_NOT_VALID)
        );
    }



    @Override
    public List<UtilisateurDto> findAll() {
        return utilisateurRepository.findAll().stream()
                .map(UtilisateurDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Article ID est nul");

        }
        utilisateurRepository.deleteById(id);

    }
    @Override
    public UtilisateurDto findByEmail(String email) {
        return utilisateurRepository.findUtilisateursByEmail(email)
                .map(UtilisateurDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                "Aucun Utilisateur avec l' email="+ email +"n'a etet trouve dans la BDD",
                ErrorCodes.UTILISATEUR_NOT_FOUND)
                );
    }
}
