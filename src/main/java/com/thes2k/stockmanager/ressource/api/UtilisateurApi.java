package com.thes2k.stockmanager.ressource.api;

import com.thes2k.stockmanager.dto.UtilisateurDto;
import com.thes2k.stockmanager.exception.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/utilisateurs")
public interface UtilisateurApi {
    @PostMapping(value = APP_ROOT + "/utilisateurs/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter un utilisateur", notes = "Cette methode permet d enregistrer ou modifier un utilisateur", response = UtilisateurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " utilisateur cree/modifie"),
            @ApiResponse(code = 400, message = " utilisateur n' est pas valide")
    })
    Response save(@RequestBody UtilisateurDto dto);

    @GetMapping(value = APP_ROOT + "/utilisateurs/{idUtilisateur}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher un utilisateur", notes = "Cette methode permet de Rechercher  un utilisateur par son ID", response = UtilisateurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L' utilisateur a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucun utilisateur n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    UtilisateurDto findById(@PathVariable("idUtilisateur") Long id);

    @GetMapping(value = APP_ROOT + "/utilisateurs/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des utilisateurs", notes = "Cette methode permet de renvoyer la liste des utilisateurs qui se trouve dans la BDD", responseContainer = "List<UtilisateurDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des utilisateurs / une liste vide "),
    })
    List<UtilisateurDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/utilisateurs/delete/{idUtilisateur}")
    @ApiOperation(value = "Supprimer un utilisateur", notes = "Cette methode permet de Supprimer  un utilisateur par son ID", response = UtilisateurDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "L utilisateur a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idUtilisateur") Long id);


}
