package com.nanou.GestiondeStock.model;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.Collection;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "category ")
public class Category extends AbstractEntity {
    private Integer idEntreprise;
    @Column(name = "codeCategory")
    private String codeCategory;
    @Column(name = "designation")
    private String designation;
    @OneToMany(mappedBy = "category")
    private Collection<Article> articles;

}
