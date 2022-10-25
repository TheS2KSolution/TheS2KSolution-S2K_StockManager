package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.RoleName;
import com.thes2k.stockmanager.model.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Roles, Long> {
    Roles findByRoleName(RoleName roleName);
}
