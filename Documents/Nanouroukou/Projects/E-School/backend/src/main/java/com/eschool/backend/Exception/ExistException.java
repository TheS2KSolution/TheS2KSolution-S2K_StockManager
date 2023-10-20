package com.eschool.backend.Exception;

import lombok.Getter;

@Getter
public class ExistException extends RuntimeException {
    private int status;

    public ExistException(String message) {
        super(message);
    }


    public ExistException(int status, String message) {
        super(message);
        this.status = status;
    }


}
