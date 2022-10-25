package com.thes2k.stockmanager.service.feature;

import com.thes2k.stockmanager.dto.CompteDto;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import com.thes2k.stockmanager.model.SuperAdmin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface CompteService {
    void refreshToken(HttpServletRequest request, HttpServletResponse response);

    Response saveRole(Roles roles);

    Response addRoleToCompte(String usernameOrEmailOrPhone, RoleName roleName);

    Response saveCompte(CompteDto compteDto);

    List<CompteDto> listCompte();

    Compte detailCompte(Long id);

    Response disable(Long id);

    Response enable(Long id);

    Response delete(Long id);

    Boolean saveAdmin(SuperAdmin superAdmin);
}
