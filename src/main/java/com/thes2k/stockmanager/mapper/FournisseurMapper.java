package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.FournisseurDto;
import com.thes2k.stockmanager.model.Fournisseur;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class FournisseurMapper {

    public FournisseurDto toEntity(Fournisseur fournisseur) {
        FournisseurDto fournisseurDto = new FournisseurDto();
        BeanUtils.copyProperties(fournisseur, fournisseurDto);
        return fournisseurDto;
    }

    public Fournisseur fromEntity(FournisseurDto fournisseurDto) {
        Fournisseur fournisseur = new Fournisseur();
        BeanUtils.copyProperties(fournisseurDto, fournisseur);
        return fournisseur;
    }


}
