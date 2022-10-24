package com.thes2k.stockmanager.exception;

import com.thes2k.stockmanager.handler.ErrorDto;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class InvalidDOperationException extends RuntimeException {

    private Integer status;
    private ErrorDto errorDto;

    public InvalidDOperationException(String message) {
        super(message);
    }

    public InvalidDOperationException(String message, Throwable cause) {
        super(message, cause);
    }

    public InvalidDOperationException(Integer status, String message, ErrorDto errorDto) {
        super(message);
        this.status = status;
        this.errorDto = errorDto;
    }
}

