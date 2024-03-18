package com.nanou.authservice.service.trace;

import com.nanou.authservice.domain.Trace;
import com.nanou.authservice.repository.TraceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Streamable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;

@Transactional
@RequiredArgsConstructor
@Slf4j
@Service
public class TraceServiceImpl implements TraceService {

    private final TraceRepository traceRepository;

    @Override
    public Trace save(Trace traceData) {
        return traceRepository.save(traceData);
    }


    public List<Trace> findAll() {
        return Streamable.of(traceRepository.findAll()).toList();
    }

    @Override
    public List<Trace> findByDateLessThan(Date date) {
        return traceRepository.findByDateLessThan(date);
    }

    @Override
    public void deleteByDateLessThan(Date date) {
        traceRepository.deleteByDateLessThan(date);
    }
}


