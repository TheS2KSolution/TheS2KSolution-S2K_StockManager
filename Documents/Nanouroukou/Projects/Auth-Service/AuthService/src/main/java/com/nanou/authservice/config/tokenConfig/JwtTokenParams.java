package com.nanou.authservice.config.tokenConfig;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "token")
public record JwtTokenParams(
        long shirtAccessTokenTimeout,
        long longAccessTokenTimeout,
        long refreshTokenTimeout
) {
}
