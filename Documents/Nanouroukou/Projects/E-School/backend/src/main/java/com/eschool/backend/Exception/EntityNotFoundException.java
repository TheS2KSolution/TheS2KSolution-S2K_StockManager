package com.eschool.backend.Exception;

import lombok.Getter;

@Getter
public class EntityNotFoundException extends RuntimeException {
    private int status;


    public EntityNotFoundException(String message) {
        super(message);
    }



    public EntityNotFoundException(int status, String message) {
        super(message);
        this.status = status;
    }


}
