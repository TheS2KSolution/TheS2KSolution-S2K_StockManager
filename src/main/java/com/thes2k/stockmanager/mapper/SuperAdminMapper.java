package com.thes2k.stockmanager.mapper;

import com.thes2k.stockmanager.dto.SuperAdminDto;
import com.thes2k.stockmanager.model.SuperAdmin;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class SuperAdminMapper {


    public SuperAdminDto toEntity(SuperAdmin superAdmin) {
        SuperAdminDto superAdminDto = new SuperAdminDto();
        BeanUtils.copyProperties(superAdmin, superAdminDto);
        return superAdminDto;
    }

    public SuperAdmin fromEntity(SuperAdminDto superAdminDto) {
        SuperAdmin superAdmin = new SuperAdmin();
        BeanUtils.copyProperties(superAdminDto, superAdmin);
        return superAdmin;
    }
}
