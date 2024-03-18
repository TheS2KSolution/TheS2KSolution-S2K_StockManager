package com.nanou.authservice.exception.domain;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class UserNotFoundException extends Exception {
    private int status;

    public UserNotFoundException(int status, String message) {
        super(message);
        this.status = status;
    }
}
