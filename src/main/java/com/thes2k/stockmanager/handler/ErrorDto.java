package com.thes2k.stockmanager.handler;

import com.thes2k.stockmanager.exception.Response;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ErrorDto {
    private Integer status;
    private Integer httpCode;
    private String message;
    private Response response;
    private List<String> erros = new ArrayList<>();

}
