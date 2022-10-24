package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.LigneVenteDto;
import com.thes2k.stockmanager.model.LigneVente;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class LigneVenteMapper {

    public LigneVenteDto toEntity(LigneVente ligneVente) {
        LigneVenteDto ligneVenteDto = new LigneVenteDto();
        BeanUtils.copyProperties(ligneVente, ligneVenteDto);
        return ligneVenteDto;
    }

    public LigneVente fromEntity(LigneVenteDto ligneVenteDto) {
        LigneVente ligneVente = new LigneVente();
        BeanUtils.copyProperties(ligneVenteDto, ligneVente);
        return ligneVente;
    }


}

