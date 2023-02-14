package com.nanou.customerservice.dao;

import com.nanou.customerservice.entities.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface CustomerDao extends JpaRepository<Customer,Long> {
}
