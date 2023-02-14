package com.nanou.billingservice.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.nanou.billingservice.model.Product;
import lombok.*;

import javax.persistence.*;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long productId;
    @ManyToOne
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Bill bill;
    private int quantity;
    private double price;
    private double discount;
    @Transient
    private Product product;
}
