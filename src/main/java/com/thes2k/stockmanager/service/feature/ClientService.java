package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.ClientDto;

import java.util.List;

public interface ClientService {
    ClientDto save(ClientDto dto);

    ClientDto findByCodeClient(String codeClient);

    ClientDto finById(Integer id);

    List<ClientDto> findAll();

    void delete(Integer id);
}
