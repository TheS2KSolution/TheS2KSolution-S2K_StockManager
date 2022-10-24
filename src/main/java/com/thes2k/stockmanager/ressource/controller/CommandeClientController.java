package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.CommandeClientDto;
import com.thes2k.stockmanager.dto.LigneCommandeClientDto;
import com.thes2k.stockmanager.model.EtatCommande;
import com.thes2k.stockmanager.ressource.api.CommandeClientApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;

@RequiredArgsConstructor
@RestController
public class CommandeClientController implements CommandeClientApi {


    @Override
    public CommandeClientDto save(CommandeClientDto dto) {
        return null;
    }

    @Override
    public CommandeClientDto updateEtatCommande(Integer idCommande, EtatCommande etatCommande) {
        return null;
    }

    @Override
    public CommandeClientDto updateClient(Integer idCommande, Integer idClient) {
        return null;
    }

    @Override
    public CommandeClientDto updateQuantiteCommande(Integer idCommande, Integer idLigneCommande, BigDecimal quantite) {
        return null;
    }

    @Override
    public CommandeClientDto findById(Integer id) {
        return null;
    }

    @Override
    public CommandeClientDto findByCodeArticle(String codeCommandeClient) {
        return null;
    }

    @Override
    public List<CommandeClientDto> findAll() {
        return null;
    }

    @Override
    public List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(Integer idCommand) {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
