package com.thes2k.stockmanager;

import com.thes2k.stockmanager.model.*;
import com.thes2k.stockmanager.repository.SuperAdminRepository;
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

        SuperAdmin superAdmin = new SuperAdmin();
        superAdmin.setFullName("S2K SuperAdmin");
        superAdmin.setEmail("thes2ksolution@gmail.com");
        superAdmin.setUsername("superadmin");
        superAdmin.setPassword("SuperAdmin");
        superAdmin.setPhone("SuperAdmin");
        superAdmin.setEtat(Etat.ACTIVER);
        superAdmin.setCreationDate(LocalDate.now());
        compteService.saveAdmin(superAdmin);
        compteService.addRoleToCompte("superadmin", RoleName.ROLE_SUPERADMIN);
    }
}
