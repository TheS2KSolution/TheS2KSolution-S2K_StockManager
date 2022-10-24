package com.thes2k.stockmanager.ressource.api;

import com.thes2k.stockmanager.dto.MvtStkDto;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.thes2k.stockmanager.utils.Constant.APP_ROOT;


public interface MvtStkApi {
    @PostMapping(value = APP_ROOT + "/mvtStk/create", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    MvtStkDto save(@RequestBody MvtStkDto dto);

    @GetMapping(value = APP_ROOT + "/mvtStk/{idMvtStk}", produces = MediaType.APPLICATION_JSON_VALUE)
    MvtStkDto findById(@PathVariable("idMvtStk") Integer id);

    @GetMapping(value = APP_ROOT + "/mvtStk/{codeMvtStk}", produces = MediaType.APPLICATION_JSON_VALUE)
    MvtStkDto findByCodeMvtStk(@PathVariable("codeMvtStk") String codeMvtStk);

    @GetMapping(value = APP_ROOT + "/mvtStk/all", produces = MediaType.APPLICATION_JSON_VALUE)
    List<MvtStkDto> findAll();

    @DeleteMapping(value = APP_ROOT + "/mvtStk/delete/{idMvtStk}")
    void delete(@PathVariable("idMvtStk") Integer id);
}