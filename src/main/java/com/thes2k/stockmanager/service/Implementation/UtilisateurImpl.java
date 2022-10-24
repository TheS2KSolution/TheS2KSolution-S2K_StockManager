package com.thes2k.stockmanager.service.Implementation;

import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.service.feature.UtilisateurService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class UtilisateurImpl implements UtilisateurService {
    @Override
    public UtilisateurDto save(UtilisateurDto utilisateurDto) {
        return null;
    }

    @Override
    public UtilisateurDto findByCodeUtilisateur(String codeUtilisateur) {
        return null;
    }

    @Override
    public UtilisateurDto finById(Integer id) {
        return null;
    }

    @Override
    public UtilisateurDto findByEmail(String email) {
        return null;
    }

    @Override
    public List<UtilisateurDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
