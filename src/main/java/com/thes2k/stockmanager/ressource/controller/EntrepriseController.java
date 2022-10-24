package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.ressource.api.EntrepriseApi;
import com.thes2k.stockmanager.service.feature.EntrepriseService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class EntrepriseController implements EntrepriseApi {
    private final EntrepriseService entrepriseService;

    @Override
    public Response save(EntrepriseDto dto) {
        return entrepriseService.save(dto);
    }

    @Override
    public EntrepriseDto findById(Integer id) {
        return null;
    }

    @Override
    public EntrepriseDto findByCodeEntreprise(String codeEntreprise) {
        return null;
    }

    @Override
    public List<EntrepriseDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
