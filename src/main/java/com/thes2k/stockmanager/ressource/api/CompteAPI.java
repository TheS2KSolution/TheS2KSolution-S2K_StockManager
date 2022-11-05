package com.thes2k.stockmanager.ressource.api;

import com.thes2k.stockmanager.dto.CompteDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.SuperAdmin;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/compte")
public interface CompteAPI {
    @GetMapping(value = APP_ROOT + "compte/refreshToken", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "refraichir le token ", notes = "Cette methode permet d refraichir le token", response = CompteDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "le token refraichit avec succes"),
            @ApiResponse(code = 400, message = "le token n'est pas refraichit avec succes")
    })
    void refreshToken(HttpServletRequest request, HttpServletResponse response);

    @PostMapping(value = APP_ROOT + "compte/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregister un compte ", notes = "Cette methode permet d enregistrer ou modifier un compte", response = CompteDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "compte creé/modifié"),
            @ApiResponse(code = 400, message = " compte n' est pas validé")
    })
    Response saveCompte(@RequestBody CompteDto compteDto);

    @PostMapping(value = APP_ROOT + "/create/super", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregister un compte super Admin ", notes = "Cette methode permet d enregistrer ou modifier un compte super Admin", response = CompteDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "compte super Admin creé/modifié"),
            @ApiResponse(code = 400, message = " compte super Admin  n' est pas validé")
    })
    Boolean saveAdmin(@RequestBody SuperAdmin superAdmin);

    @GetMapping(value = APP_ROOT + "compte/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des comptes ", notes = "Cette methode permet de renvoyer la liste des compte  qui se trouve dans la BDD", responseContainer = "List<compteDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des Comptes / une liste vide "),
    })
    List<CompteDto> listCompte();

    @GetMapping(value = APP_ROOT + "/detail/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi le detailCompte  d'un compte ", notes = "Cette methode permet de renvoyer le detailCompte se trouve dans la BDD", responseContainer = "List<compteDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le detail Compte des Comptes  "),
    })
    Compte detailCompte(@PathVariable("id") Long id);

    @GetMapping(value = APP_ROOT + "/disable/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Desactiver un compte ", notes = "Cette methode permet de Desactiver un compte qui se trouve dans la BDD", responseContainer = "List<compteDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "la desactivation du compte "),
    })
    void disable(@PathVariable("id") Long id);


    @GetMapping(value = APP_ROOT + "/enable/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Activer un compte ", notes = "Cette methode permet d' Activer un compte qui se trouve dans la BDD", responseContainer = "List<compteDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "l'Activation  du compte "),
    })
    void enable(@PathVariable("id") Long id);

    @DeleteMapping(value = APP_ROOT + "/delete/{id}")
    @ApiOperation(value = "Supprimer un Compte", notes = "Cette methode permet de Supprimer  une Compte par son ID", response = CompteDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le Compte a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("id") Long id);
}
