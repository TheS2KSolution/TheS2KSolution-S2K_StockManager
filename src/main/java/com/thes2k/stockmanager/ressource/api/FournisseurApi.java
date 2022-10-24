package com.thes2k.stockmanager.ressource.api;


import com.thes2k.stockmanager.dto.FournisseurDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/fournisseurs")
public interface FournisseurApi {
    @PostMapping(value = APP_ROOT + "/fournisseurs/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter un fournisseur", notes = "Cette methode permet d enregistrer ou modifier un fournisseur", response = FournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " fournisseur cree/modifie"),
            @ApiResponse(code = 400, message = " fournisseur n' est pas valide")
    })
    FournisseurDto save(@RequestBody FournisseurDto dto);

    @GetMapping(value = APP_ROOT + "/fournisseurs/{idFournisseur}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher un fournisseur", notes = "Cette methode permet de Rechercher  un fournisseur par son ID", response = FournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le fournisseur a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucun fournisseur n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    FournisseurDto findById(@PathVariable("idClient") Integer id);

    @GetMapping(value = APP_ROOT + "/fournisseurs/{codeFournisseur}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher un fournisseur par code fournisseur", notes = "Cette methode permet de Rechercher  un fournisseur par son CODE", response = FournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le fournisseur a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucun fournisseur n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    FournisseurDto findByCodeFournisseur(@PathVariable("codeFournisseur") String codeFournisseur);

    @GetMapping(value = APP_ROOT + "/fournisseurs/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des fournisseurs", notes = "Cette methode permet de renvoyer la liste des fournisseurs qui se trouve dans la BDD", responseContainer = "List<FournisseurDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des fournisseurs / une liste vide "),
    })
    List<FournisseurDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/fournisseurs/delete/{idFournisseur}")
    @ApiOperation(value = "Supprimer un Fournisseur", notes = "Cette methode permet de Supprimer  un Fournisseur par son ID", response = FournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le Fournisseur a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idFournisseur") Integer id);
}
