package com.nanou.GestiondeStock.exception;

import lombok.Getter;

public class InvalidDOperationException extends RuntimeException {

        @Getter
        private ErrorCodes errorCode;

    public InvalidDOperationException(String message) {
            super(message);
        }

    public InvalidDOperationException(String message, Throwable cause) {
            super(message, cause);
        }

    public InvalidDOperationException(String message, Throwable cause, ErrorCodes errorCode) {
            super(message, cause);
            this.errorCode = errorCode;
        }

    public InvalidDOperationException(String message, ErrorCodes errorCode) {
            super(message);
            this.errorCode = errorCode;
        }
    }

