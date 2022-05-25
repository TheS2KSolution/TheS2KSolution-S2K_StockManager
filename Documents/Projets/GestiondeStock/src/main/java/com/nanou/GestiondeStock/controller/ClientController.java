package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.controller.api.ClientApi;
import com.nanou.GestiondeStock.dto.ClientDto;
import com.nanou.GestiondeStock.services.ClientService;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ClientController implements ClientApi {
    private ClientService clientService;

    public ClientController(ClientService clientService) {
        this.clientService = clientService;
    }

    @Override
    public ClientDto save(ClientDto dto) {
        return clientService.save(dto);
    }

    @Override
    public ClientDto findById(Integer id) {
        return clientService.finById(id);
    }

    @Override
    public ClientDto findByCodeArticle(String codeClient) {
        return clientService.findByCodeClient(codeClient);
    }

    @Override
    public List<ClientDto> findAll() {
        return clientService.findAll();
    }

    @Override
    public void delete(Integer id) {
        clientService.delete(id);

    }
}
