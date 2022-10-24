package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.ArticleDto;
import com.thes2k.stockmanager.model.Article;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class ArticleMapper {
    public ArticleDto toEntity(Article article) {
        ArticleDto articleDto = new ArticleDto();
        BeanUtils.copyProperties(article, articleDto);
        return articleDto;
    }

    public Article fromEntity(ArticleDto articleDto) {
        Article article = new Article();
        BeanUtils.copyProperties(articleDto, article);
        return article;
    }

}
