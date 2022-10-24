package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.VentesDto;
import com.thes2k.stockmanager.ressource.api.VenteApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class VenteController implements VenteApi {

    @Override
    public VentesDto save(VentesDto dto) {
        return null;
    }

    @Override
    public VentesDto findById(Integer id) {
        return null;
    }

    @Override
    public VentesDto findByCodeVente(String codeVente) {
        return null;
    }

    @Override
    public List<VentesDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
