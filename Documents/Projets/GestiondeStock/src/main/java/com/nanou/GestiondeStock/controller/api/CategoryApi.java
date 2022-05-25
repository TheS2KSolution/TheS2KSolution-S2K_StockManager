package com.nanou.GestiondeStock.controller.api;

import com.nanou.GestiondeStock.dto.ArticleDto;
import com.nanou.GestiondeStock.dto.CategoryDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.nanou.GestiondeStock.utils.Constants.APP_ROOT;

@Api(APP_ROOT + "/catogories")
public interface CategoryApi {
    @PostMapping(value = APP_ROOT + "/catogories/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter une catogorie", notes = "Cette methode permet d enregistrer ou modifier une catogorie", response = CategoryDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L'objet catogorie cree/modifie"),
            @ApiResponse(code = 400, message = "L'objet catogorie n' est pas valide")
    })
    CategoryDto save(@RequestBody CategoryDto dto);

    @GetMapping(value = APP_ROOT + "/catogories/{idCategory}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une catogorie", notes = "Cette methode permet de Rechercher  une catogorie par son ID", response = CategoryDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La catogorie a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune catogorie n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    CategoryDto findById(@PathVariable("idCategory") Integer id);

    @GetMapping(value = APP_ROOT + "/catogories/{codeCategory}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une catogorie par code catogorie", notes = "Cette methode permet de Rechercher  une catogorie par son CODE", response = CategoryDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La catogorie a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune catogorie n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    CategoryDto findByCodeCategory(@PathVariable("codeCategory") String codeCategory);

    @GetMapping(value = APP_ROOT + "/catogories/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des catogories", notes = "Cette methode permet de renvoyer la liste des catogories qui se trouve dans la BDD", responseContainer = "List<CategoryDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des catogories / une liste vide "),
    })
    List<CategoryDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/catogories/delete/{idCategory}")
    @ApiOperation(value = "Supprimer une catogorie", notes = "Cette methode permet de Supprimer  une catogorie par son ID", response = CategoryDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La catogorie a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idCategory") Integer id);

}
