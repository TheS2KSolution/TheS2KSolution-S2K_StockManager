package com.nanou.authservice.service.role;

import com.nanou.authservice.domain.Permission;
import com.nanou.authservice.domain.Role;
import com.nanou.authservice.dtos.dtos.FonctionalityDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Transactional
@Service
public interface RoleService {
    Role save(Role role);

    Optional<Role> findById(Long id);

    Role findByRoleName(String roleName);

    List<Role> findAll();

    Role requestForRoleToUserAttribution(String roleName, String code);

    void deleteRole(Long id);

    Role removeRoleFromUser(String roleName, String code);

    List<FonctionalityDto> getFonctionalities();

    Role addRoleToUser(String username, String roleName, boolean deleteRequestRole);
}
