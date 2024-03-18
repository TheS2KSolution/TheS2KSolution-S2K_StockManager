package com.nanou.authservice.exception.domain;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class NotAnImageFileException extends Exception {
    private int status;

    public NotAnImageFileException(int status, String message) {
        super(message);
        this.status = status;
    }
}
