package com.thes2k.stockmanager.mapper;


import com.thes2k.stockmanager.dto.RolesDto;
import com.thes2k.stockmanager.model.Roles;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class RolesMapper {
    public RolesDto toEntity(Roles roles) {
        RolesDto rolesDto = new RolesDto();
        BeanUtils.copyProperties(roles, rolesDto);
        return rolesDto;
    }

    public Roles fromEntity(RolesDto rolesDto) {
        Roles roles = new Roles();
        BeanUtils.copyProperties(rolesDto, roles);
        return roles;
    }

}
