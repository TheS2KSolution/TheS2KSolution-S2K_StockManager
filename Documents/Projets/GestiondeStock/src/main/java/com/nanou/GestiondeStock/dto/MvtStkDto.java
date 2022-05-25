package com.nanou.GestiondeStock.dto;

import com.nanou.GestiondeStock.model.Article;
import com.nanou.GestiondeStock.model.MvtStk;
import com.nanou.GestiondeStock.model.TypeMvtStk;
import lombok.Builder;
import lombok.Data;


import java.math.BigDecimal;
import java.time.Instant;

@Builder
@Data
public class MvtStkDto {
    private Integer id;
    private Article article;

    private Instant dateMvt;

    private BigDecimal quantite;

    private TypeMvtStk typeMvtStk;

    public static MvtStkDto fromEntity(MvtStk mvtStk) {
        if (mvtStk == null) {
            return null;
        }
        return MvtStkDto.builder()
                .id(mvtStk.getId())
                .article(mvtStk.getArticle())
                .dateMvt(mvtStk.getDateMvt())
                .quantite(mvtStk.getQuantite())
                .typeMvtStk(mvtStk.getTypeMvtStk())
                .build();
    }

    public static MvtStk toEntity(MvtStkDto mvtStkDto) {
        if (mvtStkDto == null) {
            return null;
        }
        MvtStk mvtStk = new MvtStk();
        mvtStk.setId(mvtStkDto.getId());
        mvtStk.setArticle(mvtStkDto.getArticle());
        mvtStk.setDateMvt(mvtStkDto.getDateMvt());
        mvtStk.setQuantite(mvtStkDto.getQuantite());
        mvtStk.setTypeMvtStk(mvtStkDto.getTypeMvtStk());
        return mvtStk;
    }
}

