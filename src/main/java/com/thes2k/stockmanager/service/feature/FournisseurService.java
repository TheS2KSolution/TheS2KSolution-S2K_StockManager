package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.FournisseurDto;

import java.util.List;

public interface FournisseurService {
    FournisseurDto save(FournisseurDto dto);

    FournisseurDto findByCodeFournisseur(String CodeFournisseur);

    FournisseurDto finById(Integer id);

    List<FournisseurDto> findAll();

    void delete(Integer id);
}
