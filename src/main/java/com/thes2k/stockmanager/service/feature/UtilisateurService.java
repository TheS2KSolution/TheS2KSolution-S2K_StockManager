package com.thes2k.stockmanager.service.feature;

import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.exception.Response;

import java.util.List;

public interface UtilisateurService {
    Response save(UtilisateurDto dto);
    UtilisateurDto finById(Long id);
    List<UtilisateurDto> findAll();
    Response delete(Long id);
    Response update(UtilisateurDto utilisateurDto);
}
