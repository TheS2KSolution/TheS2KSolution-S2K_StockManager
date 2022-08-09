package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.UtilisateurDto;

import java.util.List;

public interface UtilisateurService {
    UtilisateurDto save(UtilisateurDto dto);

    UtilisateurDto findByCodeUtilisateur(String codeUtilisateur);

    UtilisateurDto finById(Integer id);

    UtilisateurDto findByEmail(String email);

    List<UtilisateurDto> findAll();

    void delete(Integer id);
}