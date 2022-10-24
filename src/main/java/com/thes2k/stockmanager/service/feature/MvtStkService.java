package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.MvtStkDto;

import java.util.List;

public interface MvtStkService {
    MvtStkDto save(MvtStkDto dto);

    MvtStkDto findByCodeMvtStk(String codeMvtStk);

    MvtStkDto finById(Integer id);

    List<MvtStkDto> findAll();

    void delete(Integer id);
}
