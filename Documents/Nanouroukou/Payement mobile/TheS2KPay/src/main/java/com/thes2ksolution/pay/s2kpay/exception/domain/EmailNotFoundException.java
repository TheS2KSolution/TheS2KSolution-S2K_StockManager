package com.thes2ksolution.pay.s2kpay.exception.domain;

public class EmailNotFoundException extends Exception {
    private int status;
    public EmailNotFoundException(int status,String message) {
        super(message);
        this.status =status;
    }
}
