package com.thes2k.stockmanager.dto;


import com.thes2k.stockmanager.model.TypeMvtStk;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
public class MvtStkDto {
    private Integer id;
    private String codeMvtStk;
    private Instant dateMvt;
    private BigDecimal quantite;
    private TypeMvtStk typeMvtStk;
    private ArticleDto articleDto;
    private LocalDate creationDate = LocalDate.now();
    private LocalDate lastModifiedDate;
}

