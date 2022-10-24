package com.thes2k.stockmanager;

import com.thes2k.stockmanager.model.Etat_Compte;
import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import com.thes2k.stockmanager.model.SuperAdmin;
import com.thes2k.stockmanager.service.Implementation.CompteServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.time.LocalDateTime;

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

        SuperAdmin superAdmin = new SuperAdmin();
        superAdmin.setFullName("S2K SuperAdmin");
        superAdmin.setEmail("thes2ksolution@gmail.com");
        superAdmin.setUsername("superadmin");
        superAdmin.setPassword("hello@2022");
        superAdmin.setPhone("SuperAdmin");
        superAdmin.setEtatCompte(Etat_Compte.ACTIVER);
        superAdmin.setCreationDate(LocalDateTime.now());
        compteService.saveAdmin(superAdmin);
        compteService.addRoleToCompte("superadmin", RoleName.ROLE_SUPERADMIN);
    }
}
