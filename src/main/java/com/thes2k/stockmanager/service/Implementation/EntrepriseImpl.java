package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.EntityNotFoundException;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.mapper.EntrepriseMapper;
import com.thes2k.stockmanager.model.Entreprise;
import com.thes2k.stockmanager.model.Etat_Compte;
import com.thes2k.stockmanager.repository.EntrepriseRepository;
import com.thes2k.stockmanager.service.feature.EntrepriseService;
import com.thes2k.stockmanager.validator.EntrepriseValidator;
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
public class EntrepriseImpl implements EntrepriseService {
    private final EntrepriseMapper entrepriseMapper;
    private final EntrepriseRepository entrepriseRepository;
    Response response = new Response();

    public Response save(EntrepriseDto entrepriseDto) {
        boolean isCompteExists = checkIfCompteExists(entrepriseDto.getUsername(), entrepriseDto.getEmail(), entrepriseDto.getPhone());
        Response response = new Response();
        Entreprise entreprise = entrepriseMapper.fromEntity(entrepriseDto);
        List<String> errors = EntrepriseValidator.validate(entrepriseDto);
        if (!errors.isEmpty()) {
            throw new InvalidEntityException(-1, "Merci de bien verifier vos informations", errors);
        } else if (!isCompteExists) {
            response.setStatus(0);
            response.setMsg("ce compte existe déja ");
        } else {
            Entreprise savedEntreprise = entrepriseRepository.save(entreprise);
            entrepriseMapper.toEntity(savedEntreprise);
            response.setStatus(1);
            response.setMsg("Entreprise Enregistré avec succes");
            response.setResult(entrepriseMapper.toEntity(entreprise));
        }
        return response;
    }

    @Override
    public Response update(EntrepriseDto entrepriseDto) {
        boolean isCompteExists = checkIfCompteExists(entrepriseDto.getUsername(), entrepriseDto.getEmail(), entrepriseDto.getPhone());
        Response response = new Response();
        Entreprise entreprise = entrepriseMapper.fromEntity(entrepriseDto);
        List<String> errors = EntrepriseValidator.validate(entrepriseDto);
        if (!errors.isEmpty()) {
            throw new InvalidEntityException(-1, "Merci de bien verifier vos informations", errors);
        } else if (!isCompteExists) {
            response.setStatus(0);
            response.setMsg("ces informations existe déja ");
        } else {
            Entreprise savedEntreprise = entrepriseRepository.save(entreprise);
            entrepriseMapper.toEntity(savedEntreprise);
            response.setStatus(1);
            response.setMsg("Entreprise modifié avec succes");
            response.setResult(entrepriseMapper.toEntity(entreprise));
        }
        return response;
    }


    @Override
    public EntrepriseDto finById(Long id) {
        if (id == null) {
            log.error("Entreprise ID est nul");
            return null;
        }
        Entreprise entreprise = entrepriseRepository.findById(id).orElseThrow(() ->
                new EntityNotFoundException(0, "Aucun resultat trouvé avec cet id:" + id));
        return entrepriseMapper.toEntity(entreprise);
    }

    @Override
    public List<EntrepriseDto> findAll() {
        return null;
    }

    @Override
    public Response delete(Long id) {

        if (id == null) {
            response.setStatus(0);
            response.setMsg("aucun article n'appartient a ce id:" + id);
        } else {
            Entreprise deleteEntreprise = entrepriseRepository.findById(id).orElseThrow();
            deleteEntreprise.setEtatCompte(Etat_Compte.SUPPRIMER);
            entrepriseRepository.save(deleteEntreprise);
            response.setStatus(1);
            response.setMsg("Article supprimé avec succes");
        }
        return response;

    }

    public boolean checkIfCompteExists(String username, String email, String phone) {
        Entreprise existUsername = entrepriseRepository.findByUsername(username);
        Entreprise existEmail = entrepriseRepository.findByEmail(email);
        Entreprise existPhone = entrepriseRepository.findByPhone(phone);
        return existEmail == null && existUsername == null && existPhone == null;

    }
}
