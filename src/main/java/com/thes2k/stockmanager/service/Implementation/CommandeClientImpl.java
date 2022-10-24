package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.CommandeClientDto;
import com.thes2k.stockmanager.dto.LigneCommandeClientDto;
import com.thes2k.stockmanager.model.EtatCommande;
import com.thes2k.stockmanager.service.feature.CommandeClientService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class CommandeClientImpl implements CommandeClientService {
    @Override
    public CommandeClientDto save(CommandeClientDto commandeClientDto) {
        return null;
    }

    @Override
    public CommandeClientDto updateEtatCommande(Integer idCommande, EtatCommande etatCommande) {
        return null;
    }

    @Override
    public CommandeClientDto updateQuantiteCommande(Integer idCommande, Integer idLigneCommande, BigDecimal quantite) {
        return null;
    }

    @Override
    public CommandeClientDto updateClient(Integer idCommande, Integer idLigneCommande) {
        return null;
    }

    @Override
    public CommandeClientDto findById(Integer id) {
        return null;
    }

    @Override
    public CommandeClientDto findByCode(String code) {
        return null;
    }

    @Override
    public List<CommandeClientDto> findAll() {
        return null;
    }

    @Override
    public List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(Integer idCommande) {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
