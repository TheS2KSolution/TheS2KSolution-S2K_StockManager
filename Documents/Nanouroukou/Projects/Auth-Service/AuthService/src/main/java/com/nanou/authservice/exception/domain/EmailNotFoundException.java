package com.nanou.authservice.exception.domain;

public class EmailNotFoundException extends Exception {
    private int status;

    public EmailNotFoundException(int status, String message) {
        super(message);
        this.status = status;
    }

    public EmailNotFoundException(String message) {
        super(message);
    }
}
