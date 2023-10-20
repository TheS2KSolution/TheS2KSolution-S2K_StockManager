package com.eschool.backend.Exception.handlers;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ErrorDTO {
    private Integer status;
    private Integer httpCode;
    private String message;
    private List<String> errors = new ArrayList<>();


}

