package com.smart.user.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.smart.core.service.GenericService;
import com.smart.user.entity.User;

public interface UserService {
    GenericService<User> getUserGenericService();
    UserDetails findByUsername(String username) throws UsernameNotFoundException;
    long countByUsername(String username) throws UsernameNotFoundException;
    Boolean existByUsername(String username);
    long countByEmail(String email) throws UsernameNotFoundException;
    Boolean existByUserEmail(String email);
}
