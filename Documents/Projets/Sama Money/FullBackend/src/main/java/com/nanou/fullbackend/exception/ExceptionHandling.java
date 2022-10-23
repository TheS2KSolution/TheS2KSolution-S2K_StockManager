package com.nanou.fullbackend.exception;

import com.auth0.jwt.exceptions.TokenExpiredException;
import com.nanou.fullbackend.response.HttpResponse;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.client.HttpServerErrorException;

import javax.persistence.NoResultException;
import javax.security.auth.login.AccountLockedException;
import java.io.IOException;
import java.util.Objects;

import static org.springframework.http.HttpStatus.*;

@RestControllerAdvice
@Slf4j

public class ExceptionHandling  implements ErrorController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    private static final String ACCOUNT_LOCKED = "Votre compte a été verrouillé. Veuillez contacter l'administrateur";
    private static final  String METHOD_IS_NOT_ALLOWED="Tsa méthode de requête n'est pas autorisée sur ce point de terminaison. veuillez envoyer une requête '%s'";
    private static final  String INTERNAL_SERVER_ERROR_MSG="Une erreur s'est produite lors du traitement de la demande";
    private static final String INCORRECT_CREDENTIALS="Nom d'utilisateur / mot de passe incorrect. Veuillez réessayer";
    private static final String ACCOUNT_DISABLED="votre compte a été désactivé. S'il s'agit d'une erreur, veuillez contacter l'administrateur";
    private static final String ERROR_PROCESSING_FILE="Une erreur s'est produite lors du traitement du fichier";
    private static final String NOT_ENOUGH_PEMISSION="Vous n'avez pas assez d'autorisation";
    private static final String ERROR_PATH = "/errot";


    @ExceptionHandler(DisabledException.class)
    public ResponseEntity<HttpResponse> accountDisableException(){
        return createHttpResponse(BAD_REQUEST,ACCOUNT_DISABLED);
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<HttpResponse> badCredentialsException(){
        return createHttpResponse(BAD_REQUEST,INCORRECT_CREDENTIALS);
    }
    @ExceptionHandler(AccountLockedException.class)
    public ResponseEntity<HttpResponse> accountLockedException(){
        return createHttpResponse(BAD_REQUEST,ACCOUNT_LOCKED);
    }
    @ExceptionHandler(HttpServerErrorException.InternalServerError.class)
    public ResponseEntity<HttpResponse> internalServerError(){
        return createHttpResponse(BAD_REQUEST,INTERNAL_SERVER_ERROR_MSG);
    }
    @ExceptionHandler(TokenExpiredException.class)
    public ResponseEntity<HttpResponse> tokenExpiredException(TokenExpiredException exception){
        return createHttpResponse(UNAUTHORIZED,exception.getMessage());
    }
    @ExceptionHandler(EmailExistException.class)
    public ResponseEntity<HttpResponse> emailExistException(EmailExistException exception){
        return createHttpResponse(BAD_REQUEST,exception.getMessage());
    }
    @ExceptionHandler(UsernameExistException.class)
    public ResponseEntity<HttpResponse> usernameExistException(UsernameExistException exception){
        return createHttpResponse(BAD_REQUEST, exception.getMessage());
    }
    @ExceptionHandler(EmailNotFoundException.class)
    public ResponseEntity<HttpResponse> emailNotFoundException(EmailNotFoundException exception){
        return createHttpResponse(BAD_REQUEST, exception.getMessage());
    }
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<HttpResponse> methodNotSupportException(HttpRequestMethodNotSupportedException exception){
        HttpMethod supportedMethod = Objects.requireNonNull(exception.getSupportedHttpMethods().iterator().next());
        return createHttpResponse(METHOD_NOT_ALLOWED,String.format(METHOD_IS_NOT_ALLOWED,supportedMethod));
    }

//    @ExceptionHandler(NoHandlerFoundException.class)
//    public ResponseEntity<HttpResponse> noHandlerFoundException(NoHandlerFoundException exception){
//        return createHttpResponse(BAD_REQUEST, "Cette page n'a pas été trouve");
//    }
    @ExceptionHandler(Exception.class)
    public ResponseEntity<HttpResponse> internalServeErrorException( Exception exception){
        logger.error(exception.getMessage());
        return createHttpResponse(INTERNAL_SERVER_ERROR,INTERNAL_SERVER_ERROR_MSG);
    }
    @ExceptionHandler(NoResultException.class)
    public ResponseEntity<HttpResponse> notFoundException( NoResultException exception){
        logger.error(exception.getMessage());
        return createHttpResponse(BAD_REQUEST,ACCOUNT_LOCKED);
    }
    @ExceptionHandler(IOException.class)
    public ResponseEntity<HttpResponse> iOException(IOException exception){
        logger.error(exception.getMessage());
        return createHttpResponse(NOT_FOUND, exception.getMessage());
    }
    @ExceptionHandler(LockedException.class)
    public ResponseEntity<HttpResponse> c(){
        return createHttpResponse(BAD_REQUEST,ACCOUNT_LOCKED);
    }


    private ResponseEntity<HttpResponse> createHttpResponse(HttpStatus httpStatus,String message){
        HttpResponse httpResponse = new HttpResponse(httpStatus.value(),httpStatus,httpStatus.getReasonPhrase().toUpperCase(),message.toUpperCase());
        return  new ResponseEntity<>(httpResponse,httpStatus);
    }
    @RequestMapping(ERROR_PATH)
    public ResponseEntity<HttpResponse> notFound404( ){
        return createHttpResponse(NOT_FOUND, "la page non trouvé pour cet URL");
    }
    public String getErrorPath(){
        return ERROR_PATH;
    }
}
