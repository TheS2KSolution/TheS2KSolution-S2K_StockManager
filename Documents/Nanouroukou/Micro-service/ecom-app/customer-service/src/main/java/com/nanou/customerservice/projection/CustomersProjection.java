package com.nanou.customerservice.projection;

import com.nanou.customerservice.entities.Customer;
import org.springframework.data.rest.core.config.Projection;

@Projection(name = "fullCustomer",types = Customer.class)
public interface CustomersProjection {
    public  Long getId();
    public String getName();
}
