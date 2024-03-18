package com.nanou.authservice.trace;


import com.google.gson.Gson;
import com.nanou.authservice.domain.Trace;
import com.nanou.authservice.config.service.UserPrincipal;
import com.nanou.authservice.exception.TraceException;
import com.nanou.authservice.service.trace.TraceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Aspect
@Component
@Slf4j
@RequiredArgsConstructor
public class TraceAspect {
    private final TraceService iTraceDataService;

    @Around("@annotation(Trace)")
    public Object trace(ProceedingJoinPoint call) {
        log.info("start trace" + call.getSignature().getName());

        try {
            Trace trace = new Trace();
            String args = new Gson().toJson(call.getArgs());
            trace.setArgs(args);
            trace.setMethod(call.getSignature().getName());
            trace.setDate(LocalDateTime.now());
            UserPrincipal userDetails = (UserPrincipal) SecurityContextHolder.getContext()
                    .getAuthentication().getPrincipal();
            trace.setLogin(userDetails.getUsername());
            iTraceDataService.save(trace);
            return call.proceed();
        } catch (Throwable e) {
            throw new TraceException(e.getMessage());
        }
    }
}
