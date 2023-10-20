package com.eschool.backend.Exception.handlers;

import lombok.*;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ErrorEntityNotFoundExceptionDTO {
    private Integer status;
    private String message;


}
