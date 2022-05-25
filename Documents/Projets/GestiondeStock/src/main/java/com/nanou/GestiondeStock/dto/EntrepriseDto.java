package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Address;

import com.nanou.GestiondeStock.model.Entreprise;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class EntrepriseDto {
    private Integer id;

    private String nom;

    private Address adresse;

    private String codeFiscal;

    private String photo;

    private String mail;

    private String numTel;

    private String steWeb;

    private List<UtilisateurDto> utilisateurs;

    public static EntrepriseDto fromEntity(Entreprise entreprise) {
        if (entreprise == null) {
            return null;
        }
        return EntrepriseDto.builder()
                .id(entreprise.getId())
                .nom(entreprise.getNom())
                .adresse(entreprise.getAdresse())
                .codeFiscal(entreprise.getCodeFiscal())
                .photo(entreprise.getPhoto())
                .mail(entreprise.getMail())
                .numTel(entreprise.getNumTel())
                .steWeb(entreprise.getSteWeb())
                .utilisateurs(fromEntity(entreprise).getUtilisateurs())
                .build();
    }

    public static Entreprise toEntity(EntrepriseDto entrepriseDto) {
        if (entrepriseDto == null) {
            return null;
        }
        Entreprise entreprise = new Entreprise();
        entreprise.setId(entrepriseDto.getId());
        entreprise.setNom(entrepriseDto.getNom());
        entreprise.setAdresse(entrepriseDto.getAdresse());
        entreprise.setCodeFiscal(entrepriseDto.getCodeFiscal());
        entreprise.setPhoto(entrepriseDto.getPhoto());
        entreprise.setPhoto(entrepriseDto.getMail());
        entreprise.setNumTel(entrepriseDto.getNumTel());
        entreprise.setSteWeb(entrepriseDto.getSteWeb());
        return entreprise;
    }
}
