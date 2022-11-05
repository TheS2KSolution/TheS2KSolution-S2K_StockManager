package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.model.Entreprise;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Service
public class EntrepriseMapper {


    public EntrepriseDto toEntity(Entreprise entreprise) {
        EntrepriseDto entrepriseDto = new EntrepriseDto();
        entrepriseDto.setType(entreprise.getClass().getSimpleName());
        BeanUtils.copyProperties(entreprise, entrepriseDto);
        return entrepriseDto;
    }

    public Entreprise fromEntity(EntrepriseDto entrepriseDto) {
        Entreprise entreprise = new Entreprise();
        BeanUtils.copyProperties(entrepriseDto, entreprise);
        return entreprise;
    }

}
