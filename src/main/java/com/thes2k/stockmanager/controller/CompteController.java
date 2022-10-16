package com.thes2k.stockmanager.controller;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.service.CompteService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/stockmanager/compte")
public class CompteController {

    private final CompteService compteService;
    @PostMapping("/create")
    public Boolean saveCompte(@RequestBody Compte compte) {
        return compteService.saveCompte(compte);
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
