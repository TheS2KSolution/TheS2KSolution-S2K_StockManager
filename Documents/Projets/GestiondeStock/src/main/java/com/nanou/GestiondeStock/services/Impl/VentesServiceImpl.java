package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.*;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Article;
import com.nanou.GestiondeStock.model.LigneVente;
import com.nanou.GestiondeStock.model.Utilisateur;
import com.nanou.GestiondeStock.model.Ventes;
import com.nanou.GestiondeStock.repository.ArticleRepository;
import com.nanou.GestiondeStock.repository.LigneVenteRepository;
import com.nanou.GestiondeStock.repository.VentesRepository;
import com.nanou.GestiondeStock.services.VentesService;
import com.nanou.GestiondeStock.validator.VentesValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class VentesServiceImpl implements VentesService {

    private ArticleRepository articleRepository;
    private VentesRepository ventesRepository;
    private LigneVenteRepository ligneVenteRepository;

    @Autowired
    public VentesServiceImpl(ArticleRepository articleRepository, VentesRepository ventesRepository, LigneVenteRepository ligneVenteRepository) {
        this.articleRepository = articleRepository;
        this.ventesRepository = ventesRepository;
        this.ligneVenteRepository = ligneVenteRepository;
    }

    @Override
    public VentesDto save(VentesDto dto) {
        List<String> errors = VentesValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("ventes n'est pas valide");
            throw new InvalidEntityException("L objet vente n est pas valide", ErrorCodes.VENTE_NOT_VALID, errors);
        }
        List<String> articleErrors = new ArrayList<>();


        if (!articleErrors.isEmpty()) {
            log.error("un ou plusieurs articles n ont pas ete  trouve dans la base de donnees");
            throw new InvalidEntityException("", ErrorCodes.VENTE_NOT_FOUND, errors);
        }
        Ventes savedVentes = ventesRepository.save(VentesDto.toEntity(dto));

        dto.getLigneVente().forEach(ligneVenteDto -> {
            LigneVente ligneVente = LigneVenteDto.toEntity(ligneVenteDto);
            //  ligneVente .setVente(savedVentes);
            ligneVenteRepository.save(ligneVente);

        });

        return VentesDto.fromEntity(savedVentes);
    }

    @Override
    public VentesDto findById(Integer id) {
        if (id == null) {
            log.error("Vente ID est Nul");
        }
        return ventesRepository.findById(id)
                .map(VentesDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                        "Aucun vente  n a ete  trouve avec l ID " + id, ErrorCodes.COMMANDE_CLIENT_NOT_FOUND
                ));

    }

    @Override
    public VentesDto findByCodeVente(String codeVente) {
        if (!StringUtils.hasLength(codeVente)) {
            log.error("Vente Code est nul");
            return null;
        }
        Optional<Ventes> ventes = ventesRepository.findVenteByCode(codeVente);

        return Optional.of(VentesDto.fromEntity(ventes.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun Vente avec le CODE =" + codeVente + "n'ete trouve dans la Base",
                        ErrorCodes.UTILISATEUR_NOT_FOUND)

        );
    }

    @Override
    public List<VentesDto> findAll() {
        return ventesRepository.findAll().stream()
                .map(VentesDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Article ID est nul");

        }
        ventesRepository.deleteById(id);
    }
}
