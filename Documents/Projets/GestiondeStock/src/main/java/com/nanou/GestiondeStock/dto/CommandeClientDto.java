package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.CommandeClient;

import com.nanou.GestiondeStock.model.EtatCommande;
import lombok.Builder;
import lombok.Data;

import java.time.Instant;
import java.util.List;

@Builder
@Data
public class CommandeClientDto {

    private Integer id;
    private String code;

    private Instant dateCommande;
    private EtatCommande etatcommande;

    private ClientDto client;

    private List<LigneCommandeClientDto> ligneCommandeClients;

    public static CommandeClientDto fromEntity(CommandeClient commandeClient) {
        if (commandeClient == null) {
            return null;
        }
        return CommandeClientDto.builder()
                .id(commandeClient.getId())
                .code(commandeClient.getCode())
                .dateCommande(commandeClient.getDateCommande())
                .client(ClientDto.fromEntity(commandeClient.getClient()))
                .etatcommande(commandeClient.getEtatcommande())
                .build();


    }

    public static CommandeClient toEntity(CommandeClientDto commandeClientDto) {
        if (commandeClientDto == null) {
            return null;
        }
        CommandeClient commandeClient = new CommandeClient();
        commandeClient.setId(commandeClientDto.getId());
        commandeClient.setCode(commandeClientDto.getCode());
        commandeClient.setDateCommande(commandeClientDto.getDateCommande());
        commandeClient.setEtatcommande(commandeClientDto.getEtatcommande());
        commandeClient.setClient(commandeClient.getClient());
        return commandeClient;
    }
    public boolean isCommandeLivree(){
        return  EtatCommande.LIVREE.equals(this.etatcommande);
    }
}
