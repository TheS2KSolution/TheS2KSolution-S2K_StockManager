package com.eschool.backend.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class testController {
    @PostMapping("inscription")
    public void inscription(){
        log.info("la requête a abouti ");
    }
}
