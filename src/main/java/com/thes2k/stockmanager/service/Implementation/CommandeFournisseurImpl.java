package com.thes2k.stockmanager.service.Implementation;


import com.thes2k.stockmanager.dto.CommandeFournisseurDto;
import com.thes2k.stockmanager.service.feature.CommandeFournisseurService;
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
public class CommandeFournisseurImpl implements CommandeFournisseurService {
    @Override
    public CommandeFournisseurDto save(CommandeFournisseurDto commandeFournisseurDto) {
        return null;
    }

    @Override
    public CommandeFournisseurDto findById(Integer id) {
        return null;
    }

    @Override
    public CommandeFournisseurDto findByCode(String code) {
        return null;
    }

    @Override
    public List<CommandeFournisseurDto> findAll() {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }
}
