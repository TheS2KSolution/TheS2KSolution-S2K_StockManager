package com.thes2k.stockmanager.serviceImpl;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.Etat;
import com.thes2k.stockmanager.repository.CompteRepository;
import com.thes2k.stockmanager.service.CompteService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
public class CompteServiceImpl implements CompteService {

    private final CompteRepository compteRepository;
    @Override
    public Boolean saveCompte(Compte compte) {
        Compte existPhone = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getPhone());
        Compte existEmail = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getEmail());
        Compte existUsername = compteRepository.findCompteByEmailOrPhoneOrUsername(compte.getUsername());
        if (existEmail !=null || existUsername !=null || existPhone !=null){

            return false;
        }

        compteRepository.save(compte);
        return true;
    }

    @Override
    public List<Compte> listCompte() {
        return compteRepository.findAll();
    }

    @Override
    public Compte detailCompte(Long id) {
        if (id == null){
            return null;
        }
        return compteRepository.findById(id).orElseThrow();
    }

    @Override
    public void disable(Long id) {
        Compte disableCompte = compteRepository.findById(id).orElseThrow();
        disableCompte.setEtat(Etat.DESACTIVER);
    }

    @Override
    public void enable(Long id) {
        Compte enableCompte = compteRepository.findById(id).orElseThrow();
        enableCompte.setEtat(Etat.ACTIVER);
    }

    @Override
    public void delete(Long id) {
        Compte deleteCompte = compteRepository.findById(id).orElseThrow();
        deleteCompte.setEtat(Etat.SUPPRIMER);
    }
}
