package com.nanou.authservice.dtos.dtos;

import com.nanou.authservice.enumeration.enums.Gender;

public record RegistrationRequestDTO(String username, String firstName, String lastName, String email, String password,
                                     String confirmPassword, Gender gender) {
}
