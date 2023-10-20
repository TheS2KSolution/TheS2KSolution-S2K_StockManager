package com.eschool.backend.Response;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;


@Setter
@Getter
@Service
public class ResponseData {
    private int status;
    private String message;
    private Object resultat;



    public ResponseData(int status, String message, Object resultat) {
        this.status = status;
        this.message = message;
        this.resultat = resultat;
    }

    public ResponseData(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public ResponseData(int status, Object resultat) {
        this.status = status;
        this.resultat = resultat;
    }

    public ResponseData() {
    }

}
