package com.nanou.billingservice.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Product {
    private Long id;
    private String name;
    private int quantity;
    private double price;
}
