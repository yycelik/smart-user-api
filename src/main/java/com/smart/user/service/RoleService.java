package com.smart.user.service;

import java.util.Optional;

import com.smart.user.entity.Role;
import com.smart.user.enumObject.ERole;

public interface RoleService {
    Optional<Role> findByName(String name);
    Optional<Role> findByName(ERole name);
    long countByName(String name);
    Boolean existByName(String name);
}
