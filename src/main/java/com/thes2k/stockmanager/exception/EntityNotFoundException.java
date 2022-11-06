package com.thes2k.stockmanager.exception;

import com.thes2k.stockmanager.handler.ErrorDto;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EntityNotFoundException extends RuntimeException {

    private ErrorDto errorDto;
    private Integer status;

    public EntityNotFoundException(String message) {
        super(message);
    }

    public EntityNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public EntityNotFoundException(String message, Throwable cause, ErrorDto errorDto) {
        super(message, cause);
        this.errorDto = errorDto;
    }

    public EntityNotFoundException(Integer status, String message) {
        super(message);
        this.status = status;

    }

}
