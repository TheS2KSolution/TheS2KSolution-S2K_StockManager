package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.VentesDto;
import com.thes2k.stockmanager.service.feature.VentesService;
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
public class VentesImpl implements VentesService {

    @Override
    public VentesDto save(VentesDto ventesDto) {
        return null;
    }

    @Override
    public VentesDto findById(Integer id) {
        return null;
    }

    @Override
    public VentesDto findByCodeVente(String codeVente) {
        return null;
    }

    @Override
    public List<VentesDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
