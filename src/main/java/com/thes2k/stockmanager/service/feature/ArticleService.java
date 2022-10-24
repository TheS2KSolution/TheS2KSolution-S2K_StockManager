package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.ArticleDto;
import com.thes2k.stockmanager.exception.Response;

import java.util.List;

public interface ArticleService {
    Response save(ArticleDto dto);

    ArticleDto findById(Integer id);

    ArticleDto findByCodeArticle(String codeArticle);

    List<ArticleDto> findAll();

    void delete(Integer id);
}
