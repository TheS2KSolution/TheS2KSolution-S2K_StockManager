package com.nanou.authservice.dtos.dtos;

public record PasswordInitializationRequestDTO(
        String password, String confirmPassword,
        String authorizationCode, String email
) {
}
