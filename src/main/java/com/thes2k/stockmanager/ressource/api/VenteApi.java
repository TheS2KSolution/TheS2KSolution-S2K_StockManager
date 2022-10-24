package com.thes2k.stockmanager.ressource.api;


import com.thes2k.stockmanager.dto.VentesDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/ventes")
public interface VenteApi {
    @PostMapping(value = APP_ROOT + "/ventes/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter une vente", notes = "Cette methode permet d enregistrer ou modifier une vente", response = VentesDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " Vente cree/modifie"),
            @ApiResponse(code = 400, message = " Vente n' est pas valide")
    })
    VentesDto save(@RequestBody VentesDto dto);

    @GetMapping(value = APP_ROOT + "/ventes/{idVente}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une vente", notes = "Cette methode permet de Rechercher  une vente par son ID", response = VentesDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La vente a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune vente n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    VentesDto findById(@PathVariable("idVente") Integer id);

    @GetMapping(value = APP_ROOT + "/ventes/{codeVente}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une vente par code vente", notes = "Cette methode permet de Rechercher  une vente par son CODE", response = VentesDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La vente a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune vente n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    VentesDto findByCodeVente(@PathVariable("codeVente") String codeVente);

    @GetMapping(value = APP_ROOT + "/ventes/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des ventes", notes = "Cette methode permet de renvoyer la liste des ventes qui se trouve dans la BDD", responseContainer = "List<VentesDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des ventes / une liste vide "),
    })
    List<VentesDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/ventes/delete/{idVente}")
    @ApiOperation(value = "Supprimer un vente", notes = "Cette methode permet de Supprimer  un vente par son ID", response = VentesDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le vente a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idVente") Integer id);
}
