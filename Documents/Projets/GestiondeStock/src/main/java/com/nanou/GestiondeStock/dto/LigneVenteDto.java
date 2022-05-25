package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Article;
import com.nanou.GestiondeStock.model.LigneVente;
import com.nanou.GestiondeStock.model.Ventes;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Builder
@Data
public class LigneVenteDto {
    private Integer id;
    private Article article;
    private Ventes vente;
    private BigDecimal quantite;

    public LigneVenteDto fromEntity(LigneVente ligneVente) {
        if (ligneVente == null) {
            return null;
        }
        return LigneVenteDto.builder()
                .id(ligneVente.getId())
                .vente(ligneVente.getVentes())
                .quantite(ligneVente.getQuantite())
                .build();
    }

    public static LigneVente toEntity(LigneVenteDto ligneVenteDto) {
        if (ligneVenteDto == null) {
            return null;
        }
        LigneVente ligneVente = new LigneVente();
        ligneVente.setId(ligneVenteDto.getId());
        ligneVente.setVentes(ligneVenteDto.getVente());
        ligneVente.setQuantite(ligneVenteDto.getQuantite());
        return ligneVente;
    }
}

