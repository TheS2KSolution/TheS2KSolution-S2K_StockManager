package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.CompteDto;
import com.thes2k.stockmanager.model.Compte;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class CompteMapper {

    public CompteDto toEntity(Compte compte) {
        CompteDto compteDto = new CompteDto();
        BeanUtils.copyProperties(compte, compteDto);
        return compteDto;
    }

    public Compte fromEntity(CompteDto compteDto) {
        Compte compte = new Compte();
        BeanUtils.copyProperties(compteDto, compte);
        return compte;
    }

}
