package com.nanou.customerservice;

import com.nanou.customerservice.entities.Customer;
import com.nanou.customerservice.dao.CustomerDao;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;

import java.util.List;

@SpringBootApplication
public class CustomerServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CustomerServiceApplication.class, args);
    }
    @Bean
    public CommandLineRunner commandLineRunner(CustomerDao customerDao, RepositoryRestConfiguration repositoryRestConfiguration){
        return args -> {
            repositoryRestConfiguration.exposeIdsFor(Customer.class);
            customerDao.saveAll(
                    List.of(
                            Customer.builder().name("Hassan").email("hassan@gmail.com").build(),
                            Customer.builder().name("Hanane").email("hanane@gmail.com").build(),
                            Customer.builder().name("imane").email("imane@gmail.com").build()

                    )
            );
            customerDao.findAll().forEach(System.out::println);

        };
    }

}
