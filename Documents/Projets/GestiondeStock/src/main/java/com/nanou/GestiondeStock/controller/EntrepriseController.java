package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.EntrepriseApi;
import com.nanou.GestiondeStock.dto.EntrepriseDto;
import com.nanou.GestiondeStock.services.EntrepriseService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class EntrepriseController implements EntrepriseApi {
    private EntrepriseService entrepriseService;

    public EntrepriseController(EntrepriseService entrepriseService) {
        this.entrepriseService = entrepriseService;
    }

    @Override
    public EntrepriseDto save(EntrepriseDto dto) {
        return entrepriseService.save(dto);
    }

    @Override
    public EntrepriseDto findById(Integer id) {
        return entrepriseService.finById(id);
    }

    @Override
    public EntrepriseDto findByCodeEntreprise(String codeEntreprise) {
        return entrepriseService.findByCodeEntreprise(codeEntreprise);
    }

    @Override
    public List<EntrepriseDto> findAll() {
        return entrepriseService.findAll();
    }

    @Override
    public void delete(Integer id) {
        entrepriseService.delete(id);

    }
}
