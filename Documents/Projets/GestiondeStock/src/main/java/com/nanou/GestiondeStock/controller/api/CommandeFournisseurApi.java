package com.nanou.GestiondeStock.controller.api;

import com.nanou.GestiondeStock.dto.CommandeClientDto;
import com.nanou.GestiondeStock.dto.CommandeFournisseurDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.nanou.GestiondeStock.utils.Constants.APP_ROOT;

@Api(APP_ROOT + "/commandeFournisseurs")
public interface CommandeFournisseurApi {
    @PostMapping(value = APP_ROOT + "/commandeFournisseur/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter une commande Fournisseur", notes = "Cette methode permet d enregistrer ou modifier une commande Fournisseur", response = CommandeFournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " CommandeClient cree/modifie"),
            @ApiResponse(code = 400, message = " CommandeClient n' est pas valide")
    })
    CommandeFournisseurDto save(@RequestBody CommandeFournisseurDto dto);

    @GetMapping(value = APP_ROOT + "/commandeFournisseur/{idCommandeFournisseur}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une commande Fournisseur ", notes = "Cette methode permet de Rechercher  une commande Fournisseur  par son ID", response = CommandeFournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La commandcommande Fournisseur eClient a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune commande Fournisseur  n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    CommandeFournisseurDto findById(@PathVariable("codeCommandeFournisseur") Integer id);

    @GetMapping(value = APP_ROOT + "/commandeFournisseur/{codeCommandeFournisseur}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une commande Fournisseur par code commandeFournisseur", notes = "Cette methode permet de Rechercher  une commandeFournisseur par son CODE", response = CommandeFournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La commande Fournisseur a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune commande Fournisseur n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    CommandeFournisseurDto findByCodeFournisseur(@PathVariable("codeCommandeFournisseur") String codeCommandeFournisseur);

    @GetMapping(value = APP_ROOT + "/commandeFournisseur/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des commande Fournisseur", notes = "Cette methode permet de renvoyer la liste des commande Fournisseurs qui se trouve dans la BDD", responseContainer = "List<CommandeFournisseurDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des Ccmmande Fournisseurs / une liste vide "),
    })
    List<CommandeFournisseurDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/©/delete/{idCommandeFournisseur}")
    @ApiOperation(value = "Supprimer un CommandeFournisseur", notes = "Cette methode permet de Supprimer  une commandeFournisseur par son ID", response = CommandeFournisseurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La CommandeFournisseur a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("codeCommandeClien") Integer id);
}
