package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.MvtStkDto;
import com.thes2k.stockmanager.ressource.api.MvtStkApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class MvtStkController implements MvtStkApi {


    @Override
    public MvtStkDto save(MvtStkDto dto) {
        return null;
    }

    @Override
    public MvtStkDto findById(Integer id) {
        return null;
    }

    @Override
    public MvtStkDto findByCodeMvtStk(String codeMvtStk) {
        return null;
    }

    @Override
    public List<MvtStkDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
