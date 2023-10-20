package com.thes2ksolution.pay.s2kpay.exception.domain;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class UsernameExistException extends Exception {
    private int status;
    public UsernameExistException(int status,String message) {
        super(message);
        this.status =status;
    }
}
