package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.MvtStkDto;
import com.thes2k.stockmanager.model.MvtStk;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class MvtStkMapper {
    public MvtStkDto toEntity(MvtStk mvtStk) {
        MvtStkDto mvtStkDto = new MvtStkDto();
        BeanUtils.copyProperties(mvtStk, mvtStkDto);
        return mvtStkDto;
    }

    public MvtStk fromEntity(MvtStkDto mvtStkDto) {
        MvtStk mvtStk = new MvtStk();
        BeanUtils.copyProperties(mvtStkDto, mvtStk);
        return mvtStk;
    }

}

