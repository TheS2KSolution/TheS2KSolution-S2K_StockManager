package com.nanou.GestiondeStock.dto;


import com.nanou.GestiondeStock.model.Article;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Builder
@Data

public class ArticleDto {

    private Integer id;
    private String codeArticle;

    private String designation;

    private BigDecimal prixUnitaireht;

    private BigDecimal tauxTva;

    private BigDecimal prixUnitaireTtc;

    private String photo;
    private Integer idEntreprise;

    private CategoryDto category;


    public static ArticleDto fromEntity(Article article) {
        if (article == null) {
            return null;
        }
        return ArticleDto.builder()
                .id(article.getId())
                .codeArticle(article.getCodeArticle())
                .designation(article.getDesignation())
                .prixUnitaireht(article.getPrixUnitaireht())
                .tauxTva(article.getTauxTva())
                .idEntreprise(article.getIdEntreprise())
                .prixUnitaireTtc(article.getPrixUnitaireTtc())
                .photo(article.getPhoto())
                .category(CategoryDto.fromEntity(article.getCategory()))
                .build();
    }

    public static Article toEntity(ArticleDto articleDto) {
        if (articleDto == null) {
            return null;
        }
        Article article = new Article();
        article.setCodeArticle(articleDto.getCodeArticle());
        article.setId(articleDto.getId());
        article.setDesignation(articleDto.getDesignation());
        article.setPrixUnitaireht(articleDto.prixUnitaireht);
        article.setPrixUnitaireTtc(articleDto.prixUnitaireTtc);
        article.setTauxTva(articleDto.getTauxTva());
        article.setIdEntreprise(articleDto.getIdEntreprise());
        article.setCategory(CategoryDto.toEntity(articleDto.getCategory()));
        article.setPhoto(articleDto.getPhoto());
        return article;
    }
}
