package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.CommandeClientDto;
import com.thes2k.stockmanager.model.CommandeClient;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Service
public class CommandeClientMapper {

    public CommandeClientDto toEntity(CommandeClient commandeClient) {
        CommandeClientDto commandeClientDto = new CommandeClientDto();
        BeanUtils.copyProperties(commandeClient, commandeClientDto);
        return commandeClientDto;
    }

    public CommandeClient fromEntity(CommandeClientDto commandeClientDto) {
        CommandeClient commandeClient = new CommandeClient();
        BeanUtils.copyProperties(commandeClientDto, commandeClient);
        return commandeClient;
    }


}
