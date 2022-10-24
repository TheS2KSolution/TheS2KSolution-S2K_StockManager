package com.thes2k.stockmanager.ressource.api;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/entreprise")
public interface EntrepriseApi {
    @PostMapping(value = APP_ROOT + "/entreprise/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter une entreprise", notes = "Cette methode permet d enregistrer ou modifier un entreprise", response = EntrepriseDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " Entreprise cree/modifie"),
            @ApiResponse(code = 400, message = " Entreprise n' est pas valide")
    })
    Response save(@RequestBody EntrepriseDto dto);

    @GetMapping(value = APP_ROOT + "/entreprises/{idEntreprise}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une entreprise", notes = "Cette methode permet de Rechercher  un entreprise par son ID", response = EntrepriseDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L' entreprise a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune entreprise n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    EntrepriseDto findById(@PathVariable("idEntreprise") Integer id);

    @GetMapping(value = APP_ROOT + "/entreprises/{codeEntreprise}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une entreprise par code entreprise", notes = "Cette methode permet de Rechercher  une entreprise par son CODE", response = EntrepriseDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L' entreprise a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune entreprise n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    EntrepriseDto findByCodeEntreprise(@PathVariable("codeEntreprise") String codeEntreprise);

    @GetMapping(value = APP_ROOT + "/entreprises/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des entreprises", notes = "Cette methode permet de renvoyer la liste des entreprises qui se trouve dans la BDD", responseContainer = "List<EntrepriseDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des entreprises / une liste vide "),
    })
    List<EntrepriseDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/entreprises/delete/{idEntreprise}")
    @ApiOperation(value = "Supprimer une entreprise", notes = "Cette methode permet de Supprimer  une entreprise par son ID", response = EntrepriseDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L' entreprise a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idEntreprise") Integer id);
}
