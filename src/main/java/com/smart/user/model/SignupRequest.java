package com.smart.user.model;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;

public class SignupRequest {
    @Getter @Setter
    private String username;

    @Getter @Setter
    private String email;

    @Getter @Setter
    private String password;

    @Getter @Setter
    private Set<String> role;
}
