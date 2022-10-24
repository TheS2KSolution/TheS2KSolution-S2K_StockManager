package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.ClientDto;
import com.thes2k.stockmanager.service.feature.ClientService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
@Setter
public class ClientImpl implements ClientService {
    @Override
    public ClientDto save(ClientDto clientDto) {
        return null;
    }

    @Override
    public ClientDto findByCodeClient(String codeClient) {
        return null;
    }

    @Override
    public ClientDto finById(Integer id) {
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
