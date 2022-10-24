package com.thes2k.stockmanager.mapper;

import com.thes2k.stockmanager.dto.LigneCommandeFournisseurDto;
import com.thes2k.stockmanager.model.LigneCommandeFournisseur;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class LigneCommandeFournisseurMapper {

    public LigneCommandeFournisseurDto toEntity(LigneCommandeFournisseur ligneCommandeFournisseur) {
        LigneCommandeFournisseurDto ligneCommandeFournisseurDto = new LigneCommandeFournisseurDto();
        BeanUtils.copyProperties(ligneCommandeFournisseur, ligneCommandeFournisseurDto);
        return ligneCommandeFournisseurDto;
    }

    public LigneCommandeFournisseur fromEntity(LigneCommandeFournisseurDto ligneCommandeFournisseurDto) {
        LigneCommandeFournisseur ligneCommandeFournisseur = new LigneCommandeFournisseur();
        BeanUtils.copyProperties(ligneCommandeFournisseurDto, ligneCommandeFournisseur);
        return ligneCommandeFournisseur;
    }

}
