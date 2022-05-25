package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.CommandeClientDto;
import com.nanou.GestiondeStock.dto.LigneCommandeClientDto;
import com.nanou.GestiondeStock.model.EtatCommande;


import java.math.BigDecimal;
import java.util.List;

public interface CommandeClientService {
    CommandeClientDto save(CommandeClientDto dto);
    CommandeClientDto updateEtatCommande(Integer idCommande, EtatCommande etatCommande);
    CommandeClientDto updateQuantiteCommande(Integer idCommande, Integer idLigneCommande, BigDecimal quantite);
    CommandeClientDto updateClient(Integer idCommande, Integer idLigneCommande);


    CommandeClientDto findById(Integer id);

    CommandeClientDto findByCode(String code);

   // CommandeClientDto findByAllByCommandeClientId(Integer idCommande);

    List<CommandeClientDto> findAll();

    List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(Integer idCommande);

    void delete(Integer id);

}
