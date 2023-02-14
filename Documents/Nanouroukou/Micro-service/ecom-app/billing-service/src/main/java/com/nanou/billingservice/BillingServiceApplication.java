package com.nanou.billingservice;

import com.nanou.billingservice.dao.BillDao;
import com.nanou.billingservice.dao.ProductItemDao;
import com.nanou.billingservice.entities.Bill;
import com.nanou.billingservice.entities.ProductItem;
import com.nanou.billingservice.model.Customer;
import com.nanou.billingservice.model.Product;
import com.nanou.billingservice.service.CustomerRestClient;
import com.nanou.billingservice.service.ProductRestClient;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

import java.util.Collection;
import java.util.Date;
import java.util.Random;

@SpringBootApplication
@EnableFeignClients
public class BillingServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(BillingServiceApplication.class, args);
    }

    @Bean
    CommandLineRunner start(BillDao billDao,
                            ProductItemDao productItemDao,
                            CustomerRestClient customerRestClient,
                            ProductRestClient productRestClient){
        return args -> {
            Collection<Product> products =productRestClient.allProducts().getContent();
            Long customerId = 2L;
            Customer customer = customerRestClient.findCustomerById(customerId);
            if(customer == null) throw new RuntimeException("customer not found");
            Bill bill = new Bill();
            bill.setBilDate(new Date());
            bill.setCustomerId(customerId);
            Bill saveBill = billDao.save(bill);
            products.forEach(product -> {
                ProductItem productItem = new ProductItem();
                productItem.setBill(saveBill);
                productItem.setProductId(product.getId());
                productItem.setQuantity(1+new Random().nextInt(10));
                productItem.setPrice(product.getPrice());
                productItem.setDiscount(Math.random());
                productItemDao.save(productItem);
            });
        };
    }
}

