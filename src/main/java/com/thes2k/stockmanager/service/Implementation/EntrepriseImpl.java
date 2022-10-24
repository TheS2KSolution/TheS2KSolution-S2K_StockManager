package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.EntrepriseDto;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import com.thes2k.stockmanager.exception.Response;
import com.thes2k.stockmanager.mapper.EntrepriseMapper;
import com.thes2k.stockmanager.model.Entreprise;
import com.thes2k.stockmanager.repository.EntrepriseRepository;
import com.thes2k.stockmanager.service.feature.EntrepriseService;
import com.thes2k.stockmanager.validator.EntrepriseValidator;
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
public class EntrepriseImpl implements EntrepriseService {
    private final EntrepriseMapper entrepriseMapper;
    private final EntrepriseRepository entrepriseRepository;

    public Response save(EntrepriseDto entrepriseDto) {
        Response response = new Response();
        Entreprise entreprise = entrepriseMapper.fromEntity(entrepriseDto);
        List<String> errors = EntrepriseValidator.validate(entrepriseDto);
        if (!errors.isEmpty()) {
            throw new InvalidEntityException(0, "Merci de bien verifier vos informations", errors);
        } else {
            System.out.println(entrepriseDto);
            Entreprise savedEntreprise = entrepriseRepository.save(entreprise);
            entrepriseMapper.toEntity(savedEntreprise);
            response.setStatus(1);
            response.setMsg("Entreprise Enregistré avec succes");
            response.setResult(entrepriseMapper.toEntity(entreprise));
        }
        return response;
    }

    @Override
    public EntrepriseDto findByCodeEntreprise(String codeEntreprise) {
        return null;
    }

    @Override
    public EntrepriseDto finById(Integer id) {
        return null;
    }

    @Override
    public List<EntrepriseDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
