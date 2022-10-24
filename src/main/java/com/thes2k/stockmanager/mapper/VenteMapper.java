package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.VentesDto;
import com.thes2k.stockmanager.model.Ventes;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class VenteMapper {
    public VentesDto toEntity(Ventes ventes) {
        VentesDto ventesDto = new VentesDto();
        BeanUtils.copyProperties(ventes, ventesDto);
        return ventesDto;
    }

    public Ventes fromEntity(VentesDto ventesDto) {
        Ventes ventes = new Ventes();
        BeanUtils.copyProperties(ventes, ventesDto);
        return ventes;
    }

}
