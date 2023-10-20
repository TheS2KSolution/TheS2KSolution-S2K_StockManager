package com.eschool.backend.Exception;

import lombok.Getter;

import java.util.List;

@Getter
public class InvalidEntityException extends RuntimeException {
    private int status;


    public InvalidEntityException(String message) {
        super(message);
    }



    public InvalidEntityException(int status, List<String> errors) {
        this.status = status;

    }

    public InvalidEntityException(String message, List<String> errors) {
        super(message);
    }


    public InvalidEntityException(int status, String message) {
        super(message);
        this.status = status;

    }



}
