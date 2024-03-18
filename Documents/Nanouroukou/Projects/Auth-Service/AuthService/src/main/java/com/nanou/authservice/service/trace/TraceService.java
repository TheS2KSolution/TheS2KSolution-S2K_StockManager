package com.nanou.authservice.service.trace;

import com.nanou.authservice.domain.Trace;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;

@Transactional
@Service
public interface TraceService {
    Trace save(Trace traceData);

    List<Trace> findAll();

    List<Trace> findByDateLessThan(Date date);

    void deleteByDateLessThan(Date date);

}
