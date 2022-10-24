package com.thes2k.stockmanager.handler;


import com.thes2k.stockmanager.exception.EntityNotFoundException;
import com.thes2k.stockmanager.exception.InvalidDOperationException;
import com.thes2k.stockmanager.exception.InvalidEntityException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class RestExceptionHandler extends ResponseEntityExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ErrorDto> handleException(EntityNotFoundException exception, WebRequest webRequest) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ErrorDto errorDto = ErrorDto.builder()
                .message(exception.getMessage())
                .httpCode(notFound.value())
                .status(exception.getStatus())
                .build();
        return new ResponseEntity<>(errorDto, notFound);
    }

    @ExceptionHandler(InvalidEntityException.class)
    public ResponseEntity<ErrorDto> handleException(InvalidEntityException exception, WebRequest webRequest) {
        final HttpStatus badRequest = HttpStatus.BAD_REQUEST;
        final ErrorDto errorDto = new ErrorDto().builder()
                .httpCode(badRequest.value())
                .message(exception.getMessage())
                .status(exception.getStatus())
                .erros(exception.getErrors()).build();
        return new ResponseEntity<>(errorDto, badRequest);
    }

    @ExceptionHandler(InvalidDOperationException.class)
    public ResponseEntity<ErrorDto> handleException(InvalidDOperationException exception, WebRequest webRequest) {
        final HttpStatus badRequest = HttpStatus.BAD_REQUEST;
        final ErrorDto errorDto = new ErrorDto().builder()
                .httpCode(badRequest.value())
                .message(exception.getMessage())
                .status(exception.getStatus())
                .build();
        return new ResponseEntity<>(errorDto, badRequest);
    }
}
