package com.eschool.backend.Exception.handlers;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ErrorInvalidEntityNotFoundExceptionDTO {
    private Integer status;
    private String message;


}
