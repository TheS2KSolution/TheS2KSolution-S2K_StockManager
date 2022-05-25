package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "MvtStk ")
public class MvtStk extends AbstractEntity {
    @Column(name = "identreprise")
    private Integer identreprise;
    @Column(name = "dateMvt")
    private Instant dateMvt;
    @Column(name = "quantite")
    private BigDecimal quantite;
    @Column(name = "typemvt")
    private TypeMvtStk typeMvtStk;
    private String codeMvtStk;

    @ManyToOne
    private Article article;


}
