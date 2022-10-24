package com.thes2k.stockmanager.ressource.api;


import com.thes2k.stockmanager.dto.CommandeClientDto;
import com.thes2k.stockmanager.dto.LigneCommandeClientDto;
import com.thes2k.stockmanager.model.EtatCommande;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;

@Api(APP_ROOT + "/commandeClients")
public interface CommandeClientApi {
    @PostMapping(value = APP_ROOT + "/commandeClients/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Enregidter une CommandeClient", notes = "Cette methode permet d enregistrer ou modifier une CommandeClient", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " CommandeClient cree/modifie"),
            @ApiResponse(code = 400, message = " CommandeClient n' est pas valide")
    })
    CommandeClientDto save(@RequestBody CommandeClientDto dto);

    @PatchMapping(value = APP_ROOT + "/commandeClients/update/etat/{idCommande}/{etatCommande}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "modifier une Commande Client", notes = "Cette methode permet de  modifier une Commande Client", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " CommandeClient modifie"),
            @ApiResponse(code = 400, message = " CommandeClient n' est pas valide")
    })
    CommandeClientDto updateEtatCommande(@PathVariable("idCommande") Integer idCommande, @PathVariable("etatCommande") EtatCommande etatCommande);

    @PatchMapping(value = APP_ROOT + "/commandeClients/update/client/{idCommande}/{idLigneClient}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "modifier un Client", notes = "Cette methode permet de  modifier  Client", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " Client modifie"),
            @ApiResponse(code = 400, message = " Client n' est pas valide")
    })
    CommandeClientDto updateClient(@PathVariable("idCommande") Integer idCommande, @PathVariable("idClient") Integer idClient);

    @PatchMapping(value = APP_ROOT + "/commandeClients/update/quantite/{idCommande}/{idLigneCommande}/{quantite}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "modifier une Quatite Client", notes = "Cette methode permet de  modifier une Quantite Client", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = " CommandeClient modifie"),
            @ApiResponse(code = 400, message = " CommandeClient n' est pas valide")
    })
    CommandeClientDto updateQuantiteCommande(@PathVariable("idCommande") Integer idCommande, @PathVariable("idLigneCommande") Integer idLigneCommande, @PathVariable("quantite") BigDecimal quantite);

    @GetMapping(value = APP_ROOT + "/commandeClients/{idCommandeClient}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une commandeClient", notes = "Cette methode permet de Rechercher  une commandeClient par son ID", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La commandeClient a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune commandeClient n'a pas ete trouver dans la BDD avec l ID fournit")
    })
    CommandeClientDto findById(@PathVariable("codeCommandeClien") Integer id);

    @GetMapping(value = APP_ROOT + "/commandeClients/{codeCommandeClient}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Rechercher une commandeClient par code commandeClient", notes = "Cette methode permet de Rechercher  une commandeClient par son CODE", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La commandeClient a ete trouver dans la BDD"),
            @ApiResponse(code = 404, message = "Aucune commandeClient n'a pas ete trouver dans la BDD avec le CODE fournit")
    })
    CommandeClientDto findByCodeArticle(@PathVariable("codeCommandeClient") String codeCommandeClient);

    @GetMapping(value = APP_ROOT + "/commandeClients/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des commandeClients", notes = "Cette methode permet de renvoyer la liste des commandeClients qui se trouve dans la BDD", responseContainer = "List<CommandeClientDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des commandeClients / une liste vide "),
    })
    List<CommandeClientDto> findAll();


    @GetMapping(value = APP_ROOT + "/commandeClients/{idCommande}", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiOperation(value = "Renvoi la liste  des commandeClients", notes = "Cette methode permet de renvoyer la liste des commandeClients qui se trouve dans la BDD", responseContainer = "List<CommandeClientDto>")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La liste des commandeClients / une liste vide "),
    })
    List<LigneCommandeClientDto> findAllLignesCommandesClientByCommandeClientId(@PathVariable("idCommande") Integer idCommand);

    @DeleteMapping(value = APP_ROOT + "/commandeClients/delete/{idCommandeClient}")
    @ApiOperation(value = "Supprimer un CommandeClient", notes = "Cette methode permet de Supprimer  une CommandeClient par son ID", response = CommandeClientDto.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "La CommandeClient a ete Supprimer dans la BDD"),
    })
    void delete(@PathVariable("codeCommandeClient") Integer id);
}
