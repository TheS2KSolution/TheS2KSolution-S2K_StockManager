package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.LigneCommandeClientDto;
import com.thes2k.stockmanager.model.LigneCommandeClient;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class LigneCommandeClientMapper {

    public LigneCommandeClientDto toEntity(LigneCommandeClient ligneCommandeClient) {
        LigneCommandeClientDto ligneCommandeClientDto = new LigneCommandeClientDto();
        BeanUtils.copyProperties(ligneCommandeClient, ligneCommandeClientDto);
        return ligneCommandeClientDto;
    }

    public LigneCommandeClient fromEntity(LigneCommandeClientDto ligneCommandeClientDto) {
        LigneCommandeClient ligneCommandeClient = new LigneCommandeClient();
        BeanUtils.copyProperties(ligneCommandeClientDto, ligneCommandeClient);
        return ligneCommandeClient;
    }

}
