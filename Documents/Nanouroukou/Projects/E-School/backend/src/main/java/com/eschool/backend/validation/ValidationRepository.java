package com.eschool.backend.validation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface ValidationRepository extends JpaRepository<Validation,Long> {
    Optional<Validation> findValidationByCode(String code);



}
