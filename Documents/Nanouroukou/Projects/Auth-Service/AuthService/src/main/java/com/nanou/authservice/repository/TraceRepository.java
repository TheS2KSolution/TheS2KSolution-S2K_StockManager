package com.nanou.authservice.repository;

import com.nanou.authservice.domain.Trace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;


@Repository
public interface TraceRepository extends JpaRepository<Trace, Long> {
    List<Trace> findByDateLessThan(Date date);

    void deleteByDateLessThan(Date date);
}
