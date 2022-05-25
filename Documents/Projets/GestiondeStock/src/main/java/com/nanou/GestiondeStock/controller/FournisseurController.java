package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.FournisseurApi;
import com.nanou.GestiondeStock.dto.FournisseurDto;
import com.nanou.GestiondeStock.services.FournisseurService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class FournisseurController implements FournisseurApi {
    private FournisseurService fournisseurService;

    public FournisseurController(FournisseurService fournisseurService) {
        this.fournisseurService = fournisseurService;
    }

    @Override
    public FournisseurDto save(FournisseurDto dto) {
        return fournisseurService.save(dto);
    }

    @Override
    public FournisseurDto findById(Integer id) {
        return fournisseurService.finById(id);
    }

    @Override
    public FournisseurDto findByCodeFournisseur(String codeFournisseur) {
        return fournisseurService.findByCodeFournisseur(codeFournisseur);
    }

    @Override
    public List<FournisseurDto> findAll() {
        return fournisseurService.findAll();
    }

    @Override
    public void delete(Integer id) {
        fournisseurService.delete(id);

    }
}
