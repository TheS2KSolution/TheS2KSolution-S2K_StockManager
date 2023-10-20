package com.eschool.backend.Exception.handlers;


import com.eschool.backend.Exception.EntityNotFoundException;
import com.eschool.backend.Exception.ExistException;
import com.eschool.backend.Exception.InvalidEntityException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class RestExceptionHandler extends ResponseEntityExceptionHandler {


    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ErrorEntityNotFoundExceptionDTO> handleException(EntityNotFoundException exception, WebRequest webRequest) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ErrorEntityNotFoundExceptionDTO errorDTO = ErrorEntityNotFoundExceptionDTO.builder()
                .status(exception.getStatus())
                .message(exception.getMessage())
                .build();
        return new ResponseEntity<>(errorDTO, notFound);
    }


    @ExceptionHandler(InvalidEntityException.class)
    public ResponseEntity<ErrorInvalidEntityNotFoundExceptionDTO> handleException(InvalidEntityException exception, WebRequest webRequest) {
        final HttpStatus badRequest = HttpStatus.BAD_REQUEST;
        final ErrorInvalidEntityNotFoundExceptionDTO errorInvalidEntityNotFoundExceptionDTO = ErrorInvalidEntityNotFoundExceptionDTO.builder()
                .status(exception.getStatus())
                .message(exception.getMessage())
                .build();

        return new ResponseEntity<>(errorInvalidEntityNotFoundExceptionDTO, badRequest);
    }

    @ExceptionHandler(ExistException.class)
    public ResponseEntity<ExistExceptionDTO> handleException(ExistException exception, WebRequest webRequest) {
        final HttpStatus findRequest = HttpStatus.OK;
        final ExistExceptionDTO errorExistExceptionDTO = ExistExceptionDTO.builder()
                .status(exception.getStatus())
                .message(exception.getMessage())
                .build();

        return new ResponseEntity<>(errorExistExceptionDTO, findRequest);
    }
}
