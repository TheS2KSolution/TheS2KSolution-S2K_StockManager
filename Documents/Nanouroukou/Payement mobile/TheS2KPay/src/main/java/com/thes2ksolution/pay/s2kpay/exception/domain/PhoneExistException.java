package com.thes2ksolution.pay.s2kpay.exception.domain;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class PhoneExistException extends Exception {
    private int status;
    public PhoneExistException(int status,String message) {
        super(message);
        this.status =status;
    }
}
