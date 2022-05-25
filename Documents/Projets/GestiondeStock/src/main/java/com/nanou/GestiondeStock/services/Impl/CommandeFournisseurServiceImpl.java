package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.CommandeFournisseurDto;
import com.nanou.GestiondeStock.dto.LigneCommandeFournisseurDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Article;
import com.nanou.GestiondeStock.model.CommandeFournisseur;
import com.nanou.GestiondeStock.model.Fournisseur;
import com.nanou.GestiondeStock.model.LigneCommandeFournisseur;
import com.nanou.GestiondeStock.repository.ArticleRepository;
import com.nanou.GestiondeStock.repository.CommandeFournisseurRepository;
import com.nanou.GestiondeStock.repository.FournisseurRepository;
import com.nanou.GestiondeStock.repository.LigneCommandeFournisseurRepository;
import com.nanou.GestiondeStock.services.CommandeFournisseurService;
import com.nanou.GestiondeStock.validator.CommandeFounisseurValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CommandeFournisseurServiceImpl implements CommandeFournisseurService {
    private CommandeFournisseurRepository commandeFournisseurRepository;
    private FournisseurRepository fournisseurRepository;
    private LigneCommandeFournisseurRepository ligneCommandeFournisseurRepository;
    private ArticleRepository articleRepository;


    public CommandeFournisseurServiceImpl(CommandeFournisseurRepository commandeFournisseurRepository, FournisseurRepository fournisseurRepository, LigneCommandeFournisseurRepository ligneCommandeFournisseurRepository, ArticleRepository articleRepository) {
        this.commandeFournisseurRepository = commandeFournisseurRepository;
        this.fournisseurRepository = fournisseurRepository;
        this.ligneCommandeFournisseurRepository = ligneCommandeFournisseurRepository;
        this.articleRepository = articleRepository;
    }

    @Override
    public CommandeFournisseurDto save(CommandeFournisseurDto dto) {
        List<String> errors = CommandeFounisseurValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("CommandeFournissuer n est pas valide{}", dto);
            throw new InvalidEntityException("La commandeFournissuer est pas valide", ErrorCodes.COMMANDE_CLIENT_NOT_VALID, errors);
        }
        Optional<Fournisseur> fournisseur = fournisseurRepository.findById(dto.getFournisseur().getId());
        if (!fournisseur.isPresent()) {
            log.warn("Fournissuer avec {} ID n a pas ete trouver dans la base de Donnees", dto.getFournisseur().getId());
            throw new EntityNotFoundException("Aucun Fournissuer avec l ID " + dto.getFournisseur().getId() + "n a ete trouver dans la base de donnees ", ErrorCodes.CLIENT_NOT_FOUND);
        }
        List<String> articleErrors = new ArrayList<>();
        if (dto.getLigneCommandeFournisseurs() != null) {
            dto.getLigneCommandeFournisseurs().forEach(ligCmdct -> {
                if (ligCmdct.getArticle() != null) {

                    Optional<Article> article = articleRepository.findById(ligCmdct.getArticle().getId());
                    if (article.isEmpty()) {
                        articleErrors.add("l article avec l ID" + ligCmdct.getArticle().getId());

                    }
                } else {
                    articleErrors.add("Impossible d enregistrer une Commande avec un article  Null");
                }
            });
        }
        if (!articleErrors.isEmpty()) {
            log.warn("");
            throw new InvalidEntityException("Article n existe Pas dans la Base de donnees", ErrorCodes.ARTICLE_NOT_FOUND, articleErrors);
        }
        CommandeFournisseur savedCmdClt = commandeFournisseurRepository.save(CommandeFournisseurDto.toEntity(dto));
        if (dto.getLigneCommandeFournisseurs() != null) {
            dto.getLigneCommandeFournisseurs().forEach(ligCmdClt -> {
                LigneCommandeFournisseur ligneCommandeFournisseur = LigneCommandeFournisseurDto.toEntity(ligCmdClt);
                ligneCommandeFournisseur.setCommandeFournisseur(savedCmdClt);
                ligneCommandeFournisseurRepository.save(ligneCommandeFournisseur);
            });
        }
        return CommandeFournisseurDto.fromEntity(savedCmdClt);
    }

    @Override
    public CommandeFournisseurDto findById(Integer id) {

        if (id == null) {
            log.error("Commande fournisseur ID est Nul");
            return null;
        }
        return commandeFournisseurRepository.findById(id)
                .map(CommandeFournisseurDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                        "Aucune commande fournisseur n a ete  trouve avec l ID " + id, ErrorCodes.COMMANDE_CLIENT_NOT_FOUND
                ));
    }

    @Override
    public CommandeFournisseurDto findByCode(String code) {

        if (code == null) {
            log.error("Commande fournisseur CODE est Nul");
            return null;
        }

        return commandeFournisseurRepository.findCommandeFournisseurByCode(code)
                .map(CommandeFournisseurDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                        "Aucune commande fournisseur n a ete  trouve avec le Code " + code, ErrorCodes.COMMANDE_FOURNISSEUR_NOT_FOUND
                ));
    }

    @Override
    public List<CommandeFournisseurDto> findAll() {

        return commandeFournisseurRepository.findAll().stream()
                .map(CommandeFournisseurDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Commande client ID est Nul");
            return;
        }
        commandeFournisseurRepository.deleteById(id);
    }

}

