package com.nanou.GestiondeStock.controller;

import com.nanou.GestiondeStock.dto.auth.AuthenticationRequest;
import com.nanou.GestiondeStock.dto.auth.AuthenticationResponse;
import com.nanou.GestiondeStock.model.auth.ExtendedUser;
import com.nanou.GestiondeStock.services.auth.ApplicationUserDetailsService;
import com.nanou.GestiondeStock.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.nanou.GestiondeStock.utils.Constants.APP_ROOT;

@RestController
@RequestMapping(APP_ROOT+"/auth")
public class AuthenticationController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private ApplicationUserDetailsService userDetailsService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request){
       authenticationManager.authenticate(
               new UsernamePasswordAuthenticationToken(
                       request.getLogin(),
                      request.getPassword()
              )
        );

        final UserDetails userDetails = userDetailsService.loadUserByUsername(request.getLogin());

        final  String jwt = jwtUtil.generateToken((ExtendedUser) userDetails);

        return  ResponseEntity.ok(AuthenticationResponse.builder().accessToken(jwt).build());


    }

}
