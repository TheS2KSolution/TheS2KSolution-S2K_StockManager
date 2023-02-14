package com.nanou.iventoryservice;

import com.nanou.iventoryservice.dao.ProductDao;
import com.nanou.iventoryservice.entities.Product;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;

import java.util.List;

@SpringBootApplication
public class IventoryServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(IventoryServiceApplication.class, args);
    }

    @Bean
    CommandLineRunner start(ProductDao productDao, RepositoryRestConfiguration repositoryRestConfiguration){
        return args -> {
            repositoryRestConfiguration.exposeIdsFor(Product.class);
            productDao.saveAll(
                    List.of(
                            Product.builder().price(123).name("Mac").quantity(12).build(),
                            Product.builder().price(124).name("Dell").quantity(12).build(),
                            Product.builder().price(125).name("Hp").quantity(12).build()

                    )

            );
            productDao.findAll().forEach(System.out::println);
        };
    }
}
