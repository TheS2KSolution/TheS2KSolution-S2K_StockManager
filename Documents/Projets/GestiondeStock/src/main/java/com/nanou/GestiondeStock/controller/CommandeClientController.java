package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.CommandeClientApi;
import com.nanou.GestiondeStock.dto.CommandeClientDto;
import com.nanou.GestiondeStock.dto.LigneCommandeClientDto;
import com.nanou.GestiondeStock.model.EtatCommande;
import com.nanou.GestiondeStock.services.CommandeClientService;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;

@RestController
public class CommandeClientController implements CommandeClientApi {
    private CommandeClientService commandeClientService;

    public CommandeClientController(CommandeClientService commandeClientService) {
        this.commandeClientService = commandeClientService;
    }

    @Override
    public CommandeClientDto save(CommandeClientDto dto) {
        return commandeClientService.save(dto);
    }

    @Override
    public CommandeClientDto updateEtatCommande(Integer idCommande, EtatCommande etatCommande) {
        return commandeClientService.updateEtatCommande(idCommande, etatCommande);
    }

    @Override
    public CommandeClientDto updateClient(Integer idCommande, Integer idClient) {
        return commandeClientService.updateClient(idCommande, idClient);
    }

    @Override
    public CommandeClientDto updateQuantiteCommande(Integer idCommande, Integer idLigneCommande, BigDecimal quantite) {
        return commandeClientService.updateQuantiteCommande(idCommande, idLigneCommande, quantite);
    }

    @Override
    public CommandeClientDto findById(Integer id) {
        return commandeClientService.findById(id);
    }

    @Override
    public CommandeClientDto findByCodeArticle(String codeCommandeClient) {
        return commandeClientService.findByCode(codeCommandeClient);
    }

    @Override
    public List<CommandeClientDto> findAll() {
        return commandeClientService.findAll();
    }

    @Override
    public List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(Integer idCommande) {
        return commandeClientService.findAllLignesCommandesClientByCommandeClientId(idCommande);
    }

    @Override
    public void delete(Integer id) {
        commandeClientService.delete(id);

    }
}
