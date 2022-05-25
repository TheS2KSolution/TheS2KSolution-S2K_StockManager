package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.VenteApi;
import com.nanou.GestiondeStock.dto.VentesDto;
import com.nanou.GestiondeStock.services.VentesService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class VenteController implements VenteApi {
    private VentesService ventesService;

    public VenteController(VentesService ventesService) {
        this.ventesService = ventesService;
    }

    @Override
    public VentesDto save(VentesDto dto) {
        return ventesService.save(dto);
    }

    @Override
    public VentesDto findById(Integer id) {
        return ventesService.findById(id);
    }

    @Override
    public VentesDto findByCodeVente(String codeVente) {
        return ventesService.findByCodeVente(codeVente);
    }

    @Override
    public List<VentesDto> findAll() {
        return ventesService.findAll();
    }

    @Override
    public void delete(Integer id) {
        ventesService.delete(id);

    }
}
