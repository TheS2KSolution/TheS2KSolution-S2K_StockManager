package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.model.Utilisateur;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Service
public class UtilisateurMapper {


    public UtilisateurDto toEntity(Utilisateur utilisateur) {
        UtilisateurDto utilisateurDto = new UtilisateurDto();
        utilisateurDto.setType(utilisateur.getClass().getSimpleName());
        BeanUtils.copyProperties(utilisateur, utilisateur);
        return utilisateurDto;
    }

    public Utilisateur fromEntity(UtilisateurDto utilisateurDto) {
        Utilisateur utilisateur = new Utilisateur();
        BeanUtils.copyProperties(utilisateurDto, utilisateur);
        return utilisateur;
    }

}
