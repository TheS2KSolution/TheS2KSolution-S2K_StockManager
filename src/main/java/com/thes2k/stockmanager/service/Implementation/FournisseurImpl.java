package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.FournisseurDto;
import com.thes2k.stockmanager.service.feature.FournisseurService;
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
public class FournisseurImpl implements FournisseurService {
    @Override
    public FournisseurDto save(FournisseurDto fournisseurDto) {
        return null;
    }

    @Override
    public FournisseurDto findByCodeFournisseur(String CodeFournisseur) {
        return null;
    }

    @Override
    public FournisseurDto finById(Integer id) {
        return null;
    }

    @Override
    public List<FournisseurDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
