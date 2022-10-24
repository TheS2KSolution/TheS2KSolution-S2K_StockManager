package com.thes2k.stockmanager.model;

import lombok.Data;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Data
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class AbstractEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "Date_Creation", nullable = false, updatable = false)
    private LocalDate creationDate = LocalDate.now();
    @LastModifiedDate
    @Column(name = "Date_Modification")
    private LocalDate lastModifiedDate;


}
