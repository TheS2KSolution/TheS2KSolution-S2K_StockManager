package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Roles;
import com.nanou.GestiondeStock.model.Utilisateur;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class RolesDto {
    private String roleName;
    private UtilisateurDto utilisateur;

    public static RolesDto fromEntity(Roles roles) {
        if (roles == null) {
            return null;
        }
        return RolesDto.builder()
                .roleName(roles.getRoleName())
               .utilisateur(UtilisateurDto.fromEntity(roles.getUtilisateur()))
                .build();
    }

    public static Roles toEntity(RolesDto rolesDto) {
        if (rolesDto == null) {
            return null;
        }
        Roles roles = new Roles();
        roles.setRoleName(rolesDto.getRoleName());
        roles.setUtilisateur(UtilisateurDto.toEntity(rolesDto.getUtilisateur()));
        return roles;
    }
}
