package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepo extends JpaRepository<Roles, Long> {
    Roles findByRoleName(RoleName roleName);
}
