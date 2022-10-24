package com.thes2k.stockmanager.mapper;

import com.thes2k.stockmanager.dto.ClientDto;
import com.thes2k.stockmanager.model.Client;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class ClientMapper {

    public ClientDto toEntity(Client client) {
        ClientDto clientDto = new ClientDto();
        BeanUtils.copyProperties(client, clientDto);
        return clientDto;
    }

    public Client fromEntity(ClientDto clientDto) {
        Client client = new Client();
        BeanUtils.copyProperties(clientDto, client);
        return client;
    }


}
