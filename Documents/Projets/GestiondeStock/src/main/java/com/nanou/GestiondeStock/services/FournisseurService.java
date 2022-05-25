package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.FournisseurDto;

import java.util.List;

public interface FournisseurService {
    FournisseurDto save(FournisseurDto dto);

    FournisseurDto findByCodeFournisseur(String CodeFournisseur);

    FournisseurDto finById(Integer id);

    List<FournisseurDto> findAll();

    void delete(Integer id);
}
