package com.nanou.authservice.dtos.dtos;

public record UserDetailsRequestDTO(String userId, String firstName, String lastName, String email) {
}
