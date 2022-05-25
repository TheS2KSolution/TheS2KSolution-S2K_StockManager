package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.ClientDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Client;
import com.nanou.GestiondeStock.repository.ClientRepository;
import com.nanou.GestiondeStock.services.ClientService;
import com.nanou.GestiondeStock.validator.ClientValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
@Slf4j
public class ClientServiceImpl implements ClientService {

    private ClientRepository clientRepository;

    public ClientServiceImpl(ClientRepository clientRepository) {
        this.clientRepository = clientRepository;
    }

    @Override
    public ClientDto save(ClientDto dto) {
        List<String> errors = ClientValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("Client n est pas valide{}", dto);
            throw new InvalidEntityException("Le Client n est pas valide", ErrorCodes.CLIENT_NOT_VALID, errors);
        }
        return ClientDto.fromEntity(clientRepository.save(
                ClientDto.toEntity(dto)
        ));
    }

    @Override
    public ClientDto findByCodeClient(String codeClient) {
        if (!StringUtils.hasLength(codeClient)) {
            log.error("Client Code est nul");
            return null;
        }
        Optional<Client> client = clientRepository.findCategoryByCodeClient(codeClient);

        return Optional.of(ClientDto.fromEntity(client.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Client article avec le CODE =" + codeClient + "n'ete trouve dans la Base",
                        ErrorCodes.ARTICLE_NOT_FOUND)
        );
    }

    @Override
    public ClientDto finById(Integer id) {
        if (id == null) {
            log.error("Client ID est nul");
            return null;
        }
        Optional<Client> client = clientRepository.findById(id);

        return Optional.of(ClientDto.fromEntity(client.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun Client avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.ARTICLE_NOT_FOUND)
        );
    }

    @Override
    public List<ClientDto> findAll() {
        return clientRepository.findAll().stream()
                .map(ClientDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("Article ID est nul");

        }
        clientRepository.deleteById(id);

    }
}
