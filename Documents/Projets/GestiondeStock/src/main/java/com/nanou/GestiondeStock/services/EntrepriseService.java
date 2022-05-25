package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.EntrepriseDto;


import java.util.List;

public interface EntrepriseService {
    EntrepriseDto save(EntrepriseDto dto);

    EntrepriseDto findByCodeEntreprise(String codeEntreprise);

    EntrepriseDto finById(Integer id);

    List<EntrepriseDto> findAll();

    void delete(Integer id);
}
