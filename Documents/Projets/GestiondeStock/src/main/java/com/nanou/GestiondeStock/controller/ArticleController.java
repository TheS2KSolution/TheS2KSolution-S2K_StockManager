package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.ArticleApi;
import com.nanou.GestiondeStock.dto.ArticleDto;
import com.nanou.GestiondeStock.services.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ArticleController implements ArticleApi {
    //    // Fiel Injection
//    @Autowired
    private ArticleService articleService;

    // Setter Injection
//    @Autowired
//    public ArticleService getArticleService(){
//        return articleService;
//    }
    // Constructor Injection
    @Autowired

    public ArticleController(ArticleService articleService) {

        this.articleService = articleService;
    }

    @Override
    public ArticleDto save(ArticleDto dto) {

        return articleService.save(dto);
    }

    @Override
    public ArticleDto findById(Integer id) {
        return articleService.findById(id);
    }

    @Override
    public ArticleDto findByCodeArticle(String codeArticle) {
        return articleService.findByCodeArticle(codeArticle);
    }

    @Override
    public List<ArticleDto> findAll() {

        return articleService.findAll();
    }

    @Override
    public void delete(Integer id) {
        articleService.delete(id);


    }
}
