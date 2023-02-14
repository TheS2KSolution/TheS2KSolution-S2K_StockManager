package com.nanou.billingservice.web;

import com.nanou.billingservice.dao.BillDao;
import com.nanou.billingservice.dao.ProductItemDao;
import com.nanou.billingservice.entities.Bill;
import com.nanou.billingservice.service.CustomerRestClient;
import com.nanou.billingservice.service.ProductRestClient;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class BillRestController {
    private final BillDao billDao;
    private final ProductItemDao productItemDao;
    private final CustomerRestClient customerRestClient;
    private final ProductRestClient productRestClient;

    @GetMapping("/fullBill/{id}")
    public Bill bill(@PathVariable Long id){
        Bill bill = billDao.findById(id).get();
        bill.setCustomer(customerRestClient.findCustomerById(bill.getCustomerId()));
        bill.getProductItems().forEach(productItem -> {
            productItem.setProduct(productRestClient.findProductById(productItem.getProductId()));
        });
        return bill;

    }
}
