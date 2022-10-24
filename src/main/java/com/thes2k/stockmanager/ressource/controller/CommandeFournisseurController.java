package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.CommandeFournisseurDto;
import com.thes2k.stockmanager.ressource.api.CommandeFournisseurApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class CommandeFournisseurController implements CommandeFournisseurApi {


    @Override
    public CommandeFournisseurDto save(CommandeFournisseurDto dto) {
        return null;
    }

    @Override
    public CommandeFournisseurDto findById(Integer id) {
        return null;
    }

    @Override
    public CommandeFournisseurDto findByCodeFournisseur(String codeCommandeFournisseur) {
        return null;
    }

    @Override
    public List<CommandeFournisseurDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
