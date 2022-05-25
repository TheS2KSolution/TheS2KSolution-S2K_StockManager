package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.ClientDto;
import com.nanou.GestiondeStock.dto.CommandeClientDto;
import com.nanou.GestiondeStock.dto.LigneCommandeClientDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidDOperationException;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.*;
import com.nanou.GestiondeStock.repository.ArticleRepository;
import com.nanou.GestiondeStock.repository.ClientRepository;
import com.nanou.GestiondeStock.repository.CommandeClientRepository;
import com.nanou.GestiondeStock.repository.LigneCommandeClientRepository;
import com.nanou.GestiondeStock.services.CommandeClientService;
import com.nanou.GestiondeStock.validator.CommandeClientValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.awt.dnd.InvalidDnDOperationException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CommandeClientServiceImpl implements CommandeClientService {
    private CommandeClientRepository commandeClientRepository;
    private ClientRepository clientRepository;
    private LigneCommandeClientRepository ligneCommandeClientRepository;
    private ArticleRepository articleRepository;

    @Autowired
    public CommandeClientServiceImpl(CommandeClientRepository commandeClientRepository, ClientRepository clientRepository, ArticleRepository articleRepository, LigneCommandeClientRepository ligneCommandeClientRepository) {
        this.commandeClientRepository = commandeClientRepository;
        this.clientRepository = clientRepository;
        this.ligneCommandeClientRepository = ligneCommandeClientRepository;
        this.articleRepository = articleRepository;
    }

    @Override
    public CommandeClientDto save(CommandeClientDto dto) {
        List<String> errors = CommandeClientValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("CommandeClient n est pas valide{}", dto);
            throw new InvalidEntityException("La commandeClient est pas valide", ErrorCodes.COMMANDE_CLIENT_NOT_VALID, errors);
        }
        if (dto.getId() !=null && dto.isCommandeLivree()){
            throw new InvalidDOperationException("Impossible de Modifier la commande lorsqu elle est livrée ", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);

        }

        Optional<Client> client = clientRepository.findById(dto.getClient().getId());
        if (!client.isPresent()) {
            log.warn("Client avec {} ID n a pas ete trouver dans la base de Donnees", dto.getClient().getId());
            throw new EntityNotFoundException("Aucun Client avec l ID " + dto.getClient().getId() + "n a ete trouver dans la base de donnees ", ErrorCodes.CLIENT_NOT_FOUND);
        }
        List<String> articleErrors = new ArrayList<>();
        if (dto.getLigneCommandeClients() != null) {
            dto.getLigneCommandeClients().forEach(ligCmdct -> {
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
        CommandeClient savedCmdClt = commandeClientRepository.save(CommandeClientDto.toEntity(dto));
        if (dto.getLigneCommandeClients() != null) {
            dto.getLigneCommandeClients().forEach(ligCmdClt -> {
                LigneCommandeClient ligneCommandeClient = LigneCommandeClientDto.toEntity(ligCmdClt);
                ligneCommandeClient.setCommandeClient(savedCmdClt);
                ligneCommandeClientRepository.save(ligneCommandeClient);
            });
        }
        return CommandeClientDto.fromEntity(savedCmdClt);
    }

    @Override
    public CommandeClientDto updateEtatCommande(Integer idCommande, EtatCommande etatCommande) {
        if (idCommande == null) {
            log.error("Commande client ID est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec un ID null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        if (!StringUtils.hasLength(String.valueOf(etatCommande))) {
            log.error("L' etat de la Commande client ID est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec un etat null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        CommandeClientDto commandeClient = findById(idCommande);

        if (commandeClient.isCommandeLivree()) {
            throw new InvalidDOperationException("Impossible de Modifier la commande lorsqu elle est livrée ", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        commandeClient.setEtatcommande(etatCommande);
        return CommandeClientDto.fromEntity(commandeClientRepository.save(
                CommandeClientDto.toEntity(commandeClient)
        ));
    }

    @Override
    public CommandeClientDto updateQuantiteCommande(Integer idCommande, Integer idLigneCommande, BigDecimal quantite) {
        if (idCommande == null) {
            log.error("Commande client ID est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec un ID null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        if (idLigneCommande == null ) {
            log.error("L' ID de la ligne  Commande  est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec ligne de  commande  null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        if (quantite == null ||  quantite.compareTo(BigDecimal.ZERO) ==0) {
            log.error("L' ID de la ligne  Commande  est null");
            throw new InvalidDOperationException("Impossible de Modifier une quantite  nulle", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }

        CommandeClientDto commandeClient = findById(idCommande);

        if (commandeClient.isCommandeLivree()) {
            throw new InvalidDOperationException("Impossible de Modifier la commande lorsqu elle est livrée ", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        Optional<LigneCommandeClient>ligneCommandeClientOptional = ligneCommandeClientRepository.findById(idLigneCommande);
        if (ligneCommandeClientOptional.isEmpty()){
            new EntityNotFoundException(
                    "Aucune ligne commande client n a ete  trouve avec l ID " + idCommande, ErrorCodes.COMMANDE_CLIENT_NOT_FOUND
            );

        }
        LigneCommandeClient ligneCommandeClient = ligneCommandeClientOptional.get();
        ligneCommandeClient.setQuantite(quantite);
        ligneCommandeClientRepository.save(ligneCommandeClient);


        return commandeClient;
    }




    @Override
    public CommandeClientDto findById(Integer id) {
        if (id == null) {
            log.error("Commande client ID est Nul");
            return null;
        }
        return commandeClientRepository.findById(id)
                .map(CommandeClientDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                        "Aucune commande client n a ete  trouve avec l ID " + id, ErrorCodes.COMMANDE_CLIENT_NOT_FOUND
                ));
    }


    @Override
    public CommandeClientDto findByCode(String code) {
        if (code == null) {
            log.error("Commande client CODE est Nul");
            return null;
        }

        return commandeClientRepository.findCommandeClientByCode(code)
                .map(CommandeClientDto::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException(
                        "Aucune commande client n a ete  trouve avec le Code " + code, ErrorCodes.COMMANDE_CLIENT_NOT_FOUND
                ));
    }


    @Override
    public List<CommandeClientDto> findAll() {
        return commandeClientRepository.findAll().stream()
                .map(CommandeClientDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(Integer idCommande) {
        return ligneCommandeClientRepository.findByAllByCommandeClientId(idCommande).stream()
                .map(LigneCommandeClientDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Commande client ID est Nul");
            return;
        }
        commandeClientRepository.deleteById(id);
    }

    @Override
    public CommandeClientDto updateClient(Integer idCommande, Integer idClient) {
        if (idCommande == null) {
            log.error("Commande client ID est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec un ID null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        if (idClient == null ) {
            log.error("L' ID du client  est null");
            throw new InvalidDOperationException("Impossible de Modifier l'etat de la commande  avec un ID Client   null", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
        CommandeClientDto commandeClient = findById(idCommande);

        if (commandeClient.isCommandeLivree()) {
            throw new InvalidDOperationException("Impossible de Modifier la commande lorsqu elle est livrée ", ErrorCodes.COMMANDE_CLIENT_NON_MODIFIABLE);
        }
      Optional<Client> clientOptional= clientRepository.findById(idClient);
        if (clientOptional.isEmpty()){

            throw new EntityNotFoundException(
                    "Aucun client n a ete avec l'ID "+idClient,ErrorCodes.CLIENT_NOT_FOUND
            );
        }
        commandeClient.setClient(ClientDto.fromEntity(clientOptional.get()));
        return CommandeClientDto.fromEntity(
                commandeClientRepository.save(CommandeClientDto.toEntity(commandeClient))
        );
    }

}
