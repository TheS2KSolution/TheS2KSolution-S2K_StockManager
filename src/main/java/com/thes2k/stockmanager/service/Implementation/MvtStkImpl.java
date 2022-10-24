package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.MvtStkDto;
import com.thes2k.stockmanager.service.feature.MvtStkService;
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
public class MvtStkImpl implements MvtStkService {
    @Override
    public MvtStkDto save(MvtStkDto mvtStkDto) {
        return null;
    }

    @Override
    public MvtStkDto findByCodeMvtStk(String codeMvtStk) {
        return null;
    }

    @Override
    public MvtStkDto finById(Integer id) {
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
