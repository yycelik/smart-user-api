package com.smart.user.model;

import lombok.Getter;
import lombok.Setter;

public class LoginRequest {
    @Getter @Setter
    private String username;

    @Getter @Setter
    private String password;
}
