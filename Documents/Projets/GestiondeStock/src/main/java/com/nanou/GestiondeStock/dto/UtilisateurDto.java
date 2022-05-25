package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Address;
import com.nanou.GestiondeStock.model.Entreprise;
import com.nanou.GestiondeStock.model.Roles;
import com.nanou.GestiondeStock.model.Utilisateur;
import lombok.Builder;
import lombok.Data;

import javax.persistence.*;
import java.time.Instant;
import java.util.List;

@Data
@Builder
public class UtilisateurDto {
    private String nom;

    private String Prenom;

    private String email;

    private Instant dateDeNaissance;

    private String motDePasse;

    private Address adresses;

    private String photo;

    private EntrepriseDto entreprise;

    private List<RolesDto> roles;

    public static UtilisateurDto fromEntity(Utilisateur utilisateur) {
        if (utilisateur == null) {
            return null;
        }
        return UtilisateurDto.builder()
                .nom(utilisateur.getNom())
                .Prenom(utilisateur.getPrenom())
                .email(utilisateur.getEmail())
                .adresses(utilisateur.getAddress())
                .dateDeNaissance(utilisateur.getDateDeNaissance())
                .motDePasse(utilisateur.getMotDePasse())
                .photo(utilisateur.getPhoto())
                .entreprise(EntrepriseDto.fromEntity(utilisateur.getEntreprise()))
                .build();
    }

    public static Utilisateur toEntity(UtilisateurDto utilisateurDto) {
        if (utilisateurDto == null) {
            return null;
        }
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(utilisateurDto.getNom());
        utilisateur.setPrenom(utilisateur.getPrenom());
        utilisateur.setEmail(utilisateurDto.getEmail());
        utilisateur.setAddress(utilisateurDto.getAdresses());
        utilisateur.setDateDeNaissance(utilisateurDto.getDateDeNaissance());
        utilisateur.setMotDePasse(utilisateurDto.getMotDePasse());
        utilisateur.setPhoto(utilisateurDto.getPhoto());
        utilisateur.setEntreprise(EntrepriseDto.toEntity(utilisateurDto.getEntreprise()));
        return utilisateur;
    }
}
