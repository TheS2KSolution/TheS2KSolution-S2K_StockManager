package com.thes2k.stockmanager.ressource.controller;


import com.thes2k.stockmanager.dto.ClientDto;
import com.thes2k.stockmanager.ressource.api.ClientApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class ClientController implements ClientApi {


    @Override
    public ClientDto save(ClientDto dto) {
        return null;
    }

    @Override
    public ClientDto findById(Integer id) {
        return null;
    }

    @Override
    public ClientDto findByCodeArticle(String codeClient) {
        return null;
    }

    @Override
    public List<ClientDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
