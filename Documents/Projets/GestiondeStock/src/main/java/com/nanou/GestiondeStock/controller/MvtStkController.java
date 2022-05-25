package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.MvtStkApi;
import com.nanou.GestiondeStock.dto.MvtStkDto;
import com.nanou.GestiondeStock.services.MvtStkService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class MvtStkController implements MvtStkApi {
    private MvtStkService mvtStkService;

    public MvtStkController(MvtStkService mvtStkService) {
        this.mvtStkService = mvtStkService;
    }

    @Override
    public MvtStkDto save(MvtStkDto dto) {
        return mvtStkService.save(dto);
    }

    @Override
    public MvtStkDto findById(Integer id) {
        return mvtStkService.finById(id);
    }

    @Override
    public MvtStkDto findByCodeMvtStk(String codeMvtStk) {
        return mvtStkService.findByCodeMvtStk(codeMvtStk);
    }

    @Override
    public List<MvtStkDto> findAll() {
        return mvtStkService.findAll();
    }

    @Override
    public void delete(Integer id) {
        mvtStkService.delete(id);

    }
}
