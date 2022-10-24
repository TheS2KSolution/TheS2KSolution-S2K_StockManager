package com.thes2k.stockmanager.exception;

import com.thes2k.stockmanager.handler.ErrorDto;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class InvalidEntityException extends RuntimeException {
    private ErrorDto errorDto;
    private List<String> errors;
    private Integer status;
    private Response response;

    public InvalidEntityException(String message) {
        super(message);
    }

    public InvalidEntityException(String message, Throwable cause) {
        super(message, cause);
    }


    public InvalidEntityException(Integer status, String message, List<String> errors) {
        super(message);
        this.errors = errors;
        this.status = status;

    }

    public InvalidEntityException(String message, List<String> errors, Response response) {
        super(message);
        this.response = response;
        this.errors = errors;
    }

    public InvalidEntityException(Integer status, String message) {
        super(message);
        this.status = status;

    }

    public InvalidEntityException(String message, ErrorDto errorDto) {
        super(message);
        this.errors = errors;
    }

    public InvalidEntityException(String message, Throwable cause, ErrorDto errorDto) {
        super(message, cause);
        this.errorDto = errorDto;
    }


}
