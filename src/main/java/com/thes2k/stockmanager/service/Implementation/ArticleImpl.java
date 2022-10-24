package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.ArticleDto;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.mapper.ArticleMapper;
import com.thes2k.stockmanager.model.Article;
import com.thes2k.stockmanager.repository.ArticleRepository;
import com.thes2k.stockmanager.service.feature.ArticleService;
import com.thes2k.stockmanager.validator.ArticleValidator;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class ArticleImpl implements ArticleService {

    private final ArticleRepository articleRepository;
    private ArticleMapper articleMapper;


    @Override
    public Response save(ArticleDto articleDto) {
        Response response = new Response();
        List<String> errors = ArticleValidator.validate(articleDto);

        if (!errors.isEmpty()) {
            throw new InvalidEntityException(0,
                    "Merci de bien verifeir vos informations");
        } else {
            Article article = articleMapper.fromEntity(articleDto);
            Article savedArticle = articleRepository.save(article);
            articleMapper.toEntity(savedArticle);
            response.setStatus(1);
            response.setMsg("Article enrégistré avec succès");
            response.setResult(article);

        }
        return response;

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
