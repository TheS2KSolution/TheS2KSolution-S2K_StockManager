package com.nanou.authservice.service.role;

import com.nanou.authservice.domain.Role;
import com.nanou.authservice.domain.User;
import com.nanou.authservice.dtos.dtos.FonctionalityDto;
import com.nanou.authservice.enumeration.permission.UserPermissions;
import com.nanou.authservice.repository.RoleRepository;
import com.nanou.authservice.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Transactional
@RequiredArgsConstructor
@Slf4j
@Service
public class RoleServiceImpl implements RoleService {
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;

    @Override
    public Role save(Role role) {
        return roleRepository.save(role);
    }

    @Override
    public Optional<Role> findById(Long id) {
        return roleRepository.findById(id);
    }

    @Override
    public Role findByRoleName(String roleName) {
        return roleRepository.findByRoleName(roleName);
    }

    @Override
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    public Role addRoleToUser(String username, String roleName, boolean deleteRequestRole) {
        User user=userRepository.findByUsername(username);
        if(user==null) throw new RuntimeException(String.format("This username %s do not exist",username));
        Role role=roleRepository.findByRoleName(roleName);
        if(role==null) throw new RuntimeException(String.format("This Role %s do not exist",roleName));
        if(user.getRole()==null) user.setRole(role);
        user.getRole();
        if(deleteRequestRole) user.getRequestedRoles().remove(roleName);
        return role;
    }

    @Override
    public void deleteRole(Long id) {
        this.roleRepository.deleteById(id);
    }

    @Override
    public List<FonctionalityDto> getFonctionalities() {
        return Arrays.stream(UserPermissions.values()).map(fonctionality ->{
            FonctionalityDto fonctionalityDTo = new FonctionalityDto();
            fonctionalityDTo.setName(fonctionality.name());
            return  fonctionalityDTo;
        }).collect(Collectors.toList());
    }
    @Override
    public Role requestForRoleToUserAttribution(String username, String roleName) {
        User user=userRepository.findByUsername(username);
        if(user==null) throw new RuntimeException(String.format("This username %s do not exist",username));
        Role role=roleRepository.findByRoleName(roleName);
        if(role==null) throw new RuntimeException(String.format("This Role %s do not exist",roleName));
        if(user.getRole()==null) user.setRole(role);
        user.getRequestedRoles().add(roleName);
        return role;
    }

    @Override
    public Role removeRoleFromUser(String username, String roleName) {
        User user=userRepository.findByUsername(username);
        if(user==null) throw new RuntimeException(String.format("This username %s do not exist",username));
        Role role=roleRepository.findByRoleName(roleName);
        if(role==null) throw new RuntimeException(String.format("This Role %s do not exist",roleName));
        user.getRole();
        return role;
    }


}
