package com.nanou.iventoryservice.dao;

import com.nanou.iventoryservice.entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ProductDao extends JpaRepository<Product,Long> {
}
