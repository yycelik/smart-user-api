package com.smart.user.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
public class JwtResponse {
    @Getter @Setter
    private String accessToken; 
    
    @Getter @Setter
    private String tokenType; 
    
    @Getter @Setter
    private long id;
    
    @Getter @Setter
    private String username; 
    
    @Getter @Setter
    private String email;
    
    @Getter @Setter
    private List<String> roles;
}
