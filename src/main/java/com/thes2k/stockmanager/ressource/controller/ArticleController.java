package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.ArticleDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.ressource.api.ArticleApi;
import com.thes2k.stockmanager.service.feature.ArticleService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class ArticleController implements ArticleApi {

    private final ArticleService articleService;

    @Override
    public Response save(ArticleDto dto) {
        return articleService.save(dto);
    }

    @Override
    public ArticleDto findById(Integer id) {
        return null;
    }

    @Override
    public ArticleDto findByCodeArticle(String codeArticle) {
        return null;
    }

    @Override
    public List<ArticleDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
