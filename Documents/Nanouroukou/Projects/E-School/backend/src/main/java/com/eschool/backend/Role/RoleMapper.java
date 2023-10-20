package com.eschool.backend.Role;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
@Service
public class RoleMapper {

        public RoleDTO toDTO(Role role) {
            if (role == null) {
                return null;
            }
            RoleDTO roleDTO = new RoleDTO();
            BeanUtils.copyProperties(role, roleDTO);
            return roleDTO;
        }

        public Role toEntity(RoleDTO roleDTO) {
            if (roleDTO == null) {
                return null;
            }
            Role role = new Role();
            BeanUtils.copyProperties(roleDTO, role);
            return role;
        }


}
