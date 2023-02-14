package com.nanou.billingservice.dao;

import com.nanou.billingservice.entities.ProductItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ProductItemDao extends JpaRepository<ProductItem,Long> {
}
