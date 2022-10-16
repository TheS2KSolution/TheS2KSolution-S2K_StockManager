package com.thes2k.stockmanager.service;

import com.thes2k.stockmanager.model.Compte;

import java.util.List;

public interface CompteService {
    Boolean saveCompte(Compte compte);
    List<Compte> listCompte();
    Compte detailCompte(Long id);
    void  disable(Long id);
    void  enable(Long id);
    void  delete(Long id);
}
