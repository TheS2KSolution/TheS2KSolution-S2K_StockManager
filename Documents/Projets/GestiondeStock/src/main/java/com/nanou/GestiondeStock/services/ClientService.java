package com.nanou.GestiondeStock.services;

import com.nanou.GestiondeStock.dto.ClientDto;
import com.nanou.GestiondeStock.dto.LigneCommandeClientDto;


import java.util.List;

public interface ClientService {
    ClientDto save(ClientDto dto);

    ClientDto findByCodeClient(String codeClient);

    ClientDto finById(Integer id);

    List<ClientDto> findAll();

    void delete(Integer id);
}
