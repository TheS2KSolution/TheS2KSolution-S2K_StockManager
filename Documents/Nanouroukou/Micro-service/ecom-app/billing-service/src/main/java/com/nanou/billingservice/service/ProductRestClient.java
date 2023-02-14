package com.nanou.billingservice.service;

import com.nanou.billingservice.model.Product;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.hateoas.PagedModel;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "INVENTORY-SERVICE")
@Service
public interface ProductRestClient {
    @GetMapping(path = "/products/{id}")
     Product findProductById(@PathVariable Long id);

    @GetMapping(path = "/products")
    PagedModel<Product> allProducts();
}
