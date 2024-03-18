package com.nanou.authservice.dtos.dtos;

public record AuthRequestDTO(
        String grantType, String username, String password, boolean withRefreshToken, String refreshToken
) {
}
