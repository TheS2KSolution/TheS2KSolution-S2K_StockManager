package com.thes2ksolution.pay.s2kpay.exception.domain;

public class EmailExistException extends Exception {
    private int status;
    public EmailExistException(int status,String message) {
        super(message);
        this.status =status;
    }

}
