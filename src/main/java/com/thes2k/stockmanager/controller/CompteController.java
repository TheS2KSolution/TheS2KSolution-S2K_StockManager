package com.thes2k.stockmanager.controller;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.Entreprise;
import com.thes2k.stockmanager.model.SuperAdmin;
import com.thes2k.stockmanager.model.Utilisateur;
import com.thes2k.stockmanager.service.CompteService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/stockmanager/compte")
public class CompteController {
    private final CompteService compteService;

    @GetMapping("/refreshToken")
    public void refreshToken(HttpServletRequest request, HttpServletResponse response){
        compteService.refreshToken(request, response);
    }

    @PostMapping("/create")
    public Boolean saveCompte(@RequestBody Compte compte) {
        return compteService.saveCompte(compte);
    }
    @PostMapping("/create/entreprise")
    public Boolean saveEnt(@RequestBody Entreprise entreprise) {
        return compteService.saveEnt(entreprise);
    }
    @PostMapping("/create/utilsateur")
    public Boolean saveutilisateur(@RequestBody Utilisateur utilisateur) {
        return compteService.saveUtilisateur(utilisateur);
    }
    @PostMapping("/create/super")
    public Boolean saveAdmin(@RequestBody SuperAdmin superAdmin) {
        return compteService.saveAdmin(superAdmin);
    }
    @GetMapping("/all")
    public List<Compte> listCompte() {
        return compteService.listCompte();
    }
    @GetMapping("/detail/{id}")
    public Compte detailCompte(@PathVariable("id") Long id) {
        return compteService.detailCompte(id);
    }
    @GetMapping("/disable/{id}")
    public void disable(@PathVariable("id") Long id) {
        compteService.disable(id);
    }

    @GetMapping("/enable/{id}")
    public void enable(@PathVariable("id") Long id) {
        compteService.enable(id);
    }

    @GetMapping("/delete/{id}")
    public void delete(@PathVariable("id") Long id) {
        compteService.delete(id);
    }
}
