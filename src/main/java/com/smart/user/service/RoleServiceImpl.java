package com.smart.user.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smart.core.enumObject.MatchMode;
import com.smart.core.service.GenericService;
import com.smart.user.entity.Role;
import com.smart.user.enumObject.ERole;

@Service
public class RoleServiceImpl implements RoleService{
    
    @Autowired
    private GenericService<Role> roleService;

    @Override
    @Transactional
    public Optional<Role> findByName(String name){
        List<Role> roleList = roleService.find(Role.class, "name", name, MatchMode.equals, 1);

        Role role = null;
        if (roleList != null && roleList.size() > 0 && roleList.size() < 2) {
            role = roleList.get(0);
        } else {
            new Exception("Role Not Found with name: " + name);
        }

        return Optional.of(role);
    }

    @Override
    @Transactional
    public Optional<Role> findByName(ERole name){
        return findByName(name.toString());
    }

    @Override
    @Transactional
    public long countByName(String name) {
        return roleService.count(Role.class, "name", name, MatchMode.equals, 1);
    }

    @Override
    @Transactional
    public Boolean existByName(String name) {
        return countByName(name) > 0 ? true : false;
    }
}
