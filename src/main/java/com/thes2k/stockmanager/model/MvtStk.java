package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import java.math.BigDecimal;
import java.time.Instant;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class MvtStk extends AbstractEntity {
    private String codeMvtStk;
    private Instant dateMvt;
    private BigDecimal quantite;
    private TypeMvtStk typeMvtStk;
    @ManyToOne
    private Article article;


}
