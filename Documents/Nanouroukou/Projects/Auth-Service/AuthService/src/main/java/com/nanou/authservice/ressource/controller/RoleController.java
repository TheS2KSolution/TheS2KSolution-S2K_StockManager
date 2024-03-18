package com.nanou.authservice.ressource.controller;

import com.nanou.authservice.domain.Role;
import com.nanou.authservice.dtos.dtos.AddRoleToUserDTO;
import com.nanou.authservice.dtos.dtos.RemoveRoleFromUserDTO;
import com.nanou.authservice.dtos.dtos.RequestForRoleToUserDTO;
import com.nanou.authservice.service.role.RoleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@Slf4j
@RequiredArgsConstructor
public class RoleController {

    private final RoleService roleService;


    @PostMapping(path = "/admin/removeRoleFromUser")
    public Role removeRoleFromUser(@RequestBody RemoveRoleFromUserDTO request) {
        return this.roleService.removeRoleFromUser(request.username(), request.roleName());
    }

    @PostMapping(path = "/admin/requestForRoleAttribution")
    public Role requestForRoleAttribution(@RequestBody RequestForRoleToUserDTO request) {
        return this.roleService.requestForRoleToUserAttribution(request.code(), request.roleName());
    }

    @PostMapping(path = "/admin/addRoleToUser")
    public Role addPermissionToRole(@RequestBody AddRoleToUserDTO request) {
        return this.roleService.addRoleToUser(request.code(), request.roleName(), request.deleteRequestRole());
    }

    @GetMapping(path = "/admin/roles")
    public List<Role> rolesList() {
        return roleService.findAll();
    }


    @PostMapping(path = "/admin/roles")
    public Role addNewRole(@RequestBody Role role) {
        return roleService.save(role);
    }


    @DeleteMapping(path = "/admin/roles/{id}")
    public void removeRole(@PathVariable Long id) {
        roleService.deleteRole(id);
    }
}
