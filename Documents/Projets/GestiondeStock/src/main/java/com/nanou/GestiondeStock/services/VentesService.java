package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.VentesDto;

import java.util.List;

public interface VentesService {
    VentesDto save(VentesDto dto);

    VentesDto findById(Integer id);

    VentesDto findByCodeVente(String codeVente);

    List<VentesDto> findAll();

    void delete(Integer id);
}
