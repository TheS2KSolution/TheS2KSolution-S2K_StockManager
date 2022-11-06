package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.Response;

import java.util.List;

public interface EntrepriseService {
    Response save(EntrepriseDto dto);

    Response update(EntrepriseDto entrepriseDto);

    EntrepriseDto finById(Long id);

    List<EntrepriseDto> findAll();

    Response delete(Long id);

}
