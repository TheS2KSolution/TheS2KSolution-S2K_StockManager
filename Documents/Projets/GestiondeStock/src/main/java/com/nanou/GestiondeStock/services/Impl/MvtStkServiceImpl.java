package com.nanou.GestiondeStock.services.Impl;

import com.nanou.GestiondeStock.dto.ClientDto;
import com.nanou.GestiondeStock.dto.MvtStkDto;
import com.nanou.GestiondeStock.exception.EntityNotFoundException;
import com.nanou.GestiondeStock.exception.ErrorCodes;
import com.nanou.GestiondeStock.exception.InvalidEntityException;
import com.nanou.GestiondeStock.model.Client;
import com.nanou.GestiondeStock.model.MvtStk;
import com.nanou.GestiondeStock.repository.MvtStkRepository;
import com.nanou.GestiondeStock.services.MvtStkService;
import com.nanou.GestiondeStock.validator.MvtStkValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
@Slf4j
public class MvtStkServiceImpl implements MvtStkService {

    private MvtStkRepository mvtStkRepository;

    public MvtStkServiceImpl(MvtStkRepository mvtStkRepository) {
        this.mvtStkRepository = mvtStkRepository;
    }

    @Override
    public MvtStkDto save(MvtStkDto dto) {
        List<String> errors = MvtStkValidator.validate(dto);
        if (!errors.isEmpty()) {
            log.error("Client n est pas valide{}", dto);
            throw new InvalidEntityException("Le Client n est pas valide", ErrorCodes.MVT_STK_NOT_VALID, errors);
        }
        return MvtStkDto.fromEntity(mvtStkRepository.save(
                MvtStkDto.toEntity(dto)
        ));
    }

    @Override
    public MvtStkDto findByCodeMvtStk(String codeMvtStk) {
        if (!StringUtils.hasLength(codeMvtStk)) {
            log.error("MvtStk Code est nul");
            return null;
        }
        Optional<MvtStk> mvtStk = mvtStkRepository.findCategoryByCodeMvtStk(codeMvtStk);

        return Optional.of(MvtStkDto.fromEntity(mvtStk.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "MvtStk article avec le CODE =" + codeMvtStk + "n'ete trouve dans la Base",
                        ErrorCodes.ARTICLE_NOT_FOUND)
        );
    }

    @Override
    public MvtStkDto finById(Integer id) {
        if (id == null) {
            log.error("Client ID est nul");
            return null;
        }
        Optional<MvtStk> mvtStk = mvtStkRepository.findById(id);

        return Optional.of(MvtStkDto.fromEntity(mvtStk.get())).orElseThrow(() ->
                new EntityNotFoundException(
                        "Aucun MvtStk avec l'ID =" + id + "n'ete trouve dans la Base",
                        ErrorCodes.MVT_STK_NOT_FOUND)
        );
    }

    @Override
    public List<MvtStkDto> findAll() {
        return mvtStkRepository.findAll().stream()
                .map(MvtStkDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Integer id) {
        if (id == null) {
            log.error("MvtStk ID est nul");

        }
        mvtStkRepository.deleteById(id);

    }

}

