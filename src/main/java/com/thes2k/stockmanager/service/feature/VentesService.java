package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.VentesDto;

import java.util.List;

public interface VentesService {
    VentesDto save(VentesDto dto);

    VentesDto findById(Integer id);

    VentesDto findByCodeVente(String codeVente);

    List<VentesDto> findAll();

    void delete(Integer id);
}
