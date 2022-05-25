package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.CommandeFournisseurApi;
import com.nanou.GestiondeStock.dto.CommandeClientDto;
import com.nanou.GestiondeStock.dto.CommandeFournisseurDto;
import com.nanou.GestiondeStock.services.CommandeFournisseurService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CommandeFournisseurController implements CommandeFournisseurApi {
    private CommandeFournisseurService commandeFournisseurService;

    public CommandeFournisseurController(CommandeFournisseurService commandeFournisseurService) {
        this.commandeFournisseurService = commandeFournisseurService;
    }

    @Override
    public CommandeFournisseurDto save(CommandeFournisseurDto dto) {
        return commandeFournisseurService.save(dto);
    }

    @Override
    public CommandeFournisseurDto findById(Integer id) {
        return commandeFournisseurService.findById(id);
    }

    @Override
    public CommandeFournisseurDto findByCodeFournisseur(String codeCommandeFournisseur) {
        return commandeFournisseurService.findByCode(codeCommandeFournisseur);
    }

    @Override
    public List<CommandeFournisseurDto> findAll() {
        return commandeFournisseurService.findAll();
    }

    @Override
    public void delete(Integer id) {
        commandeFournisseurService.delete(id);

    }
}
