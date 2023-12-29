package com.smart.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smart.core.enumObject.MatchMode;
import com.smart.core.service.GenericService;
import com.smart.user.entity.User;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private GenericService<User> userService;

    @Override
    public GenericService<User> getUserGenericService() {
        return userService;
    }

    @Override
    @Transactional
    public UserDetails findByUsername(String username) throws UsernameNotFoundException {
        List<User> userList = userService.find(User.class, "username", username, MatchMode.equals, 1);

        User user = null;
        if (userList != null && userList.size() > 0 && userList.size() < 2) {
            user = userList.get(0);
        } else {
            new UsernameNotFoundException("User Not Found with username: " + username);
        }

        return UserDetailsImpl.build(user);
    }

    @Override
    @Transactional
    public long countByUsername(String username) throws UsernameNotFoundException {
        return userService.count(User.class, "username", username, MatchMode.equals, 1);
    }

    @Override
    @Transactional
    public Boolean existByUsername(String username) {
        return countByUsername(username) > 0 ? true : false;
    }

    @Override
    @Transactional
    public long countByEmail(String email) throws UsernameNotFoundException {
        return userService.count(User.class, "email", email, MatchMode.equals, 1);
    }

    @Override
    @Transactional
    public Boolean existByUserEmail(String email) {
        return countByEmail(email) > 0 ? true : false;
    }


}