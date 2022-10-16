package com.thes2k.stockmanager.service;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;

import java.util.List;

public interface CompteService {
    void saveRole(Roles roles);
    void addRoleToCompte(String usernameOrEmailOrPhone, RoleName roleName);

    Boolean saveCompte(Compte compte);
    List<Compte> listCompte();
    Compte detailCompte(Long id);
    void  disable(Long id);
    void  enable(Long id);
    void  delete(Long id);


}
