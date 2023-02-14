package com.nanou.billingservice.service;

import com.nanou.billingservice.model.Customer;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "CUSTOMER-SERVICE")
@Service
public interface CustomerRestClient {
    @GetMapping(path = "/customers/{id}")
     Customer findCustomerById(@PathVariable Long id);
}
