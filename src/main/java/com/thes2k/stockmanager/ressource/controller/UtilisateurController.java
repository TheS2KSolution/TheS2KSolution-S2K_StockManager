package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.ressource.api.UtilisateurApi;
import com.thes2k.stockmanager.service.feature.UtilisateurService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UtilisateurController implements UtilisateurApi {

    private UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {

        this.utilisateurService = utilisateurService;
    }

    @Override
    public Response save(UtilisateurDto dto) {
        return utilisateurService.save(dto);
    }

    @Override
    public UtilisateurDto findById(Long id) {
        return utilisateurService.finById(id);
    }


    @Override
    public List<UtilisateurDto> findAll() {

        return utilisateurService.findAll();
    }

    @Override
    public void delete(Long id) {
        utilisateurService.delete(id);

    }
}
