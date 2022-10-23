package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.SuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SuperAdminRepository extends JpaRepository<SuperAdmin,Long> {
}
