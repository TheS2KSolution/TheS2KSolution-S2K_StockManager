package com.thes2k.stockmanager.service.feature;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.Response;

import java.util.List;

public interface EntrepriseService {
    Response save(EntrepriseDto dto);



    EntrepriseDto finById(Integer id);

    List<EntrepriseDto> findAll();

    void delete(Integer id);
}
