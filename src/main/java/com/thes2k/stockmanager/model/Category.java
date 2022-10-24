package com.thes2k.stockmanager.model;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import java.util.Collection;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Category extends AbstractEntity {
    private String codeCategory;
    private String designation;
    @OneToMany(mappedBy = "category")
    private Collection<Article> articles;

}
