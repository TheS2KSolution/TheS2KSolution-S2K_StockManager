package com.nanou.authservice.exception.domain;

public class EmailExistException extends Exception {
    private final int status;

    public EmailExistException(int status, String message) {
        super(message);
        this.status = status;
    }

}
