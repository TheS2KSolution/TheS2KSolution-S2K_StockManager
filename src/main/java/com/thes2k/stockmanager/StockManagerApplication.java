package com.thes2k.stockmanager;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.Etat;
import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import com.thes2k.stockmanager.serviceImpl.CompteServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.time.LocalDate;

@SpringBootApplication
@RequiredArgsConstructor
public class StockManagerApplication implements CommandLineRunner {

    private final CompteServiceImpl compteService;

    public static void main(String[] args) {
        SpringApplication.run(StockManagerApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        compteService.saveRole(new Roles(null, RoleName.ROLE_SUPERADMIN));
        compteService.saveRole(new Roles(null, RoleName.ROLE_ADMIN));

        Compte compte = new Compte(null, "Super Admin", "superadmin@thes2k.com",
                "superadmin", "hello@2022", "+2233026354", null, null, Etat.ACTIVER, LocalDate.now(), null, null);
        compteService.saveCompte(compte);
        compteService.addRoleToCompte("superadmin", RoleName.ROLE_SUPERADMIN);
    }
}
