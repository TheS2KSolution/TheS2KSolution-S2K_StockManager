package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.CommandeFournisseurDto;
import com.thes2k.stockmanager.model.CommandeFournisseur;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;


@Service
public class CommandeFournisseurMapper {

    public CommandeFournisseurDto toEntity(CommandeFournisseur commandeFournisseur) {
        CommandeFournisseurDto commandeFournisseurDto = new CommandeFournisseurDto();
        BeanUtils.copyProperties(commandeFournisseur, commandeFournisseurDto);
        return commandeFournisseurDto;
    }

    public CommandeFournisseur fromEntity(CommandeFournisseurDto commandeFournisseurDto) {
        CommandeFournisseur commandeFournisseur = new CommandeFournisseur();
        BeanUtils.copyProperties(commandeFournisseurDto, commandeFournisseur);
        return commandeFournisseur;
    }

}
