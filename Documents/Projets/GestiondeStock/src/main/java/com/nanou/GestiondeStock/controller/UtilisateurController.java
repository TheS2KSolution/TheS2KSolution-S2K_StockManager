package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.UtilisateurApi;
import com.nanou.GestiondeStock.dto.UtilisateurDto;
import com.nanou.GestiondeStock.services.UtilisateurService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UtilisateurController implements UtilisateurApi {

    private UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {

        this.utilisateurService = utilisateurService;
    }

    @Override
    public UtilisateurDto save(UtilisateurDto dto) {
        return utilisateurService.save(dto);
    }

    @Override
    public UtilisateurDto findById(Integer id) {
        return utilisateurService.finById(id);
    }

    @Override
    public UtilisateurDto findByCodeUtilisateur(String codeUtilisateur) {
        return utilisateurService.findByCodeUtilisateur(codeUtilisateur);
    }


    @Override
    public List<UtilisateurDto> findAll() {

        return utilisateurService.findAll();
    }

    @Override
    public void delete(Integer id) {
        utilisateurService.delete(id);

    }
}
