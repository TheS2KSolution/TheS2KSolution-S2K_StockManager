package com.eschool.backend.utilisateur;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class UtilisateurMapper {
    public UtilisateurDTO toDTO(Utilisateur utilisateur) {
        if (utilisateur == null) {
            return null;
        }
        UtilisateurDTO utilisateurDto = new UtilisateurDTO();
        BeanUtils.copyProperties(utilisateur, utilisateurDto);
        return utilisateurDto;
    }

    public Utilisateur toEntity(UtilisateurDTO utilisateurDTO) {
        if (utilisateurDTO == null) {
            return null;
        }
        Utilisateur utilisateur = new Utilisateur();
        BeanUtils.copyProperties(utilisateurDTO, utilisateur);
        return utilisateur;
    }

}
