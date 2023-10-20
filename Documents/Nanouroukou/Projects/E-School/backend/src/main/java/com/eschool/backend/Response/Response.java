package com.eschool.backend.Response;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;


@Setter
@Getter
@Service
public class Response {
    private int status;
    private String message;





    public Response(int status, String message) {
        this.status = status;
        this.message = message;
    }



    public Response() {
    }

}
