package com.thes2k.stockmanager.ressource.api;


import com.thes2k.stockmanager.dto.ClientDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;


@Api(APP_ROOT + "/clients")
public interface ClientApi {
    @PostMapping(value = APP_ROOT + "/clients/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter un client", notes = "Cette methode permet d enregistrer ou modifier un client", response = ClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " Client cree/modifie"),
            @ApiResponse(code = 400, message = " Client n' est pas valide")
    })
    ClientDto save(@RequestBody ClientDto dto);

    @GetMapping(value = APP_ROOT + "/clients/{idClient}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher un client", notes = "Cette methode permet de Rechercher  un client par son ID", response = ClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le client a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucun client n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    ClientDto findById(@PathVariable("idClient") Integer id);

    @GetMapping(value = APP_ROOT + "/clients/{codeClient}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher un client par code Client", notes = "Cette methode permet de Rechercher  un client par son CODE", response = ClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le client a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucun client n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    ClientDto findByCodeArticle(@PathVariable("codeClient") String codeClient);

    @GetMapping(value = APP_ROOT + "/clients/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des clients", notes = "Cette methode permet de renvoyer la liste des clients qui se trouve dans la BDD", responseContainer = "List<ClientDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des clients / une liste vide "),
    })
    List<ClientDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/clients/delete/{idClient}")
    @ApiOperation(value = "Supprimer un client", notes = "Cette methode permet de Supprimer  un client par son ID", response = ClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Le client a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("idClient") Integer id);

}
