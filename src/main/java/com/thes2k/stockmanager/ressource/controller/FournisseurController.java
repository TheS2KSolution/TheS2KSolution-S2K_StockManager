package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.FournisseurDto;
import com.thes2k.stockmanager.ressource.api.FournisseurApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class FournisseurController implements FournisseurApi {

    @Override
    public FournisseurDto save(FournisseurDto dto) {
        return null;
    }

    @Override
    public FournisseurDto findById(Integer id) {
        return null;
    }

    @Override
    public FournisseurDto findByCodeFournisseur(String codeFournisseur) {
        return null;
    }

    @Override
    public List<FournisseurDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
