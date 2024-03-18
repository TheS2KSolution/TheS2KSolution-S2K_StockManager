package com.nanou.authservice.dtos.dtos;

public record RemoveRoleFromUserDTO(
        String roleName, String username
) {
}
