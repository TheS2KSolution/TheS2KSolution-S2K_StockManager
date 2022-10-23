package com.nanou.fullbackend.exception;

public class EmailExistException extends  Exception{
    public EmailExistException(String message) {
        super(message);
    }
}
