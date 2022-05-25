package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.FournisseurDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Fournisseur;
import com.nanou.GestiondeStock.repository.FournisseurRepository;
import com.nanou.GestiondeStock.services.FournisseurService;
import com.nanou.GestiondeStock.validator.FournisseurValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class FournisseurServiceImpl implements FournisseurService {

    private FournisseurRepository fournisseurRepository;

    public FournisseurServiceImpl(FournisseurRepository fournisseurRepository) {
        this.fournisseurRepository = fournisseurRepository;

    }


    @Override
    public FournisseurDto save(FournisseurDto dto) {
        List<String> errors = FournisseurValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("Founisseur n est pas valide{}", dto);
            throw new InvalidEntityException("L article n est pas valide", ErrorCodes.FOURNISSEUR_NOT_VALID, errors);
        }
        return FournisseurDto.fromEntity(fournisseurRepository.save(
                FournisseurDto.toEntity(dto)
        ));
    }

    @Override
    public FournisseurDto findByCodeFournisseur(String CodeFournisseur) {
        if (!StringUtils.hasLength(CodeFournisseur)) {
            log.error("Fournisseur Code est nul");
            return null;
        }
        Optional<Fournisseur> fournisseur = fournisseurRepository.findByCodeFournisseur(CodeFournisseur);

        return Optional.of(FournisseurDto.fromEntity(fournisseur.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun fournisseur avec le CODE =" + CodeFournisseur + "n'ete trouve dans la Base",
                        ErrorCodes.FOURNISSEUR_NOT_FOUND)
        );
    }

    @Override
    public FournisseurDto finById(Integer id) {
        if (id == null) {
            log.error("fournisseur ID est nul");
            return null;
        }
        Optional<Fournisseur> fournisseur = fournisseurRepository.findById(id);

        return Optional.of(FournisseurDto.fromEntity(fournisseur.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun fournisseur avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.CATEGORY_NOT_FOUND)
        );

    }

    @Override
    public List<FournisseurDto> findAll() {
        return fournisseurRepository.findAll().stream()
                .map(FournisseurDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("categorie ID est nul");

        }
        fournisseurRepository.deleteById(id);


    }
}
