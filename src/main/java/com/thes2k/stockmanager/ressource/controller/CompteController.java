package com.thes2k.stockmanager.ressource.controller;

import com.thes2k.stockmanager.dto.CompteDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.SuperAdmin;
import com.thes2k.stockmanager.ressource.api.CompteAPI;
import com.thes2k.stockmanager.service.feature.CompteService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class CompteController implements CompteAPI {
    private final CompteService compteService;

    @Override

    public void refreshToken(HttpServletRequest request, HttpServletResponse response) {
        compteService.refreshToken(request, response);
    }

    @Override
    public Response saveCompte(@RequestBody CompteDto compteDto) {
        return compteService.saveCompte(compteDto);
    }

    @Override
    public Boolean saveAdmin(@RequestBody SuperAdmin superAdmin) {
        return compteService.saveAdmin(superAdmin);
    }

    @Override
    public List<CompteDto> listCompte() {
        return compteService.listCompte();
    }

    @Override
    public Compte detailCompte(@PathVariable("id") Long id) {
        return compteService.detailCompte(id);
    }

    @Override
    public void disable(@PathVariable("id") Long id) {
        compteService.disable(id);
    }

    @Override
    public void enable(@PathVariable("id") Long id) {
        compteService.enable(id);
    }

    @Override
    public void delete(@PathVariable("id") Long id) {
        compteService.delete(id);
    }
}
