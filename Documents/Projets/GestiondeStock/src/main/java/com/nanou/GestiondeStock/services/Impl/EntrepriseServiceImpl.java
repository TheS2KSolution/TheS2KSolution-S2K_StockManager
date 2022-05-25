package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.EntrepriseDto;
import com.nanou.GestiondeStock.dto.RolesDto;
import com.nanou.GestiondeStock.dto.UtilisateurDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Entreprise;
import com.nanou.GestiondeStock.repository.EntrepriseRepository;
import com.nanou.GestiondeStock.repository.RolesRepository;
import com.nanou.GestiondeStock.services.EntrepriseService;
import com.nanou.GestiondeStock.services.UtilisateurService;
import com.nanou.GestiondeStock.validator.EntrepriseValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Transactional(rollbackOn = Exception.class)
@Service
@Slf4j
public class EntrepriseServiceImpl implements EntrepriseService {

    private EntrepriseRepository entrepriseRepository;
    private RolesRepository rolesRepository;
    private UtilisateurService utilisateurService;
@Autowired
    public EntrepriseServiceImpl(EntrepriseRepository entrepriseRepository, RolesRepository rolesRepository, UtilisateurService utilisateurService) {
        this.entrepriseRepository = entrepriseRepository;
        this.rolesRepository = rolesRepository;
        this.utilisateurService = utilisateurService;
    }

    @Override
    public EntrepriseDto save(EntrepriseDto dto) {
        List<String> errors = EntrepriseValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("Entreprise n est pas valide{}", dto);
            throw new InvalidEntityException("L entreprise est pas valide", ErrorCodes.ENTREPRISE_NOT_VALID, errors);
        }
         EntrepriseDto savedEntreprise = EntrepriseDto.fromEntity (entrepriseRepository.save(
                EntrepriseDto.toEntity(dto)
        ));
        UtilisateurDto utilisateur = fromEntreprise(savedEntreprise);
        UtilisateurDto savedUser= utilisateurService.save(utilisateur);
        RolesDto rolesDto = RolesDto.builder()
                .roleName("Admin")
                .utilisateur(savedUser)
                .build();
        rolesRepository.save(RolesDto.toEntity(rolesDto));
        return  savedEntreprise;

    }


    @Override
    public EntrepriseDto findByCodeEntreprise(String codeEntreprise) {
        if (!StringUtils.hasLength(codeEntreprise)) {
            log.error("Entreprise Code est nul");
            return null;
        }
        Optional<Entreprise> entreprise = entrepriseRepository.findCategoryByCodeEntreprise(codeEntreprise);

        return Optional.of(EntrepriseDto.fromEntity(entreprise.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun Entreprise avec le CODE =" + codeEntreprise + "n'ete trouve dans la Base",
                        ErrorCodes.ENTREPRISE_NOT_FOUND)
        );
    }

    @Override
    public EntrepriseDto finById(Integer id) {
        if (id == null) {
            log.error("Entreprise ID est nul");
            return null;
        }
        Optional<Entreprise> entreprise = entrepriseRepository.findById(id);

        return entrepriseRepository.findById(id)
                .map(EntrepriseDto::fromEntity)
            .orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucune Entreprise avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.ENTREPRISE_NOT_FOUND)
        );
    }

    @Override
    public List<EntrepriseDto> findAll() {
        return entrepriseRepository.findAll().stream()
                .map(EntrepriseDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Article ID est nul");

        }
        entrepriseRepository.deleteById(id);

    }
    private UtilisateurDto fromEntreprise(EntrepriseDto dto){
        return UtilisateurDto.builder()
                .adresses(dto.getAdresse())
                .nom(dto.getNom())
                .Prenom(dto.getCodeFiscal())
                .email(dto.getMail())
                .motDePasse(generateRandomPassword())
                .entreprise(dto)
                .dateDeNaissance(Instant.now())
                .photo(dto.getPhoto())
                .build();
    }
    private String generateRandomPassword (){
        return "nanou@2075";
    }
}
