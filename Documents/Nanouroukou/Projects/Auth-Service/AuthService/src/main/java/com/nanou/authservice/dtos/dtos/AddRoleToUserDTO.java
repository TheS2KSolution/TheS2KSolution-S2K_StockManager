package com.nanou.authservice.dtos.dtos;

public record AddRoleToUserDTO(
        String roleName, String code, boolean deleteRequestRole
) {
}
