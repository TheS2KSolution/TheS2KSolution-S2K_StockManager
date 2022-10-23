package com.nanou.fullbackend.resource;

import com.nanou.fullbackend.domain.User;
import com.nanou.fullbackend.domain.UserPrincipal;
import com.nanou.fullbackend.exception.EmailExistException;
import com.nanou.fullbackend.exception.UsernameExistException;
import com.nanou.fullbackend.exception.UsernameNotFoundException;
import com.nanou.fullbackend.service.UserService;
import com.nanou.fullbackend.utility.JWTTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;

import static com.nanou.fullbackend.constant.SecurityConstant.JWT_TOKEN_HEADER;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = {"/","/user"})
public class UserResource extends Exception {
    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final JWTTokenProvider jwtTokenProvider;

    @PostMapping ("/login")
    public ResponseEntity<User> login(@RequestBody User user) {
        authenticate(user.getUsername(),user.getPassword());
        User loginUser = userService.findUserByUsername(user.getUsername());
        UserPrincipal userPrincipal = new UserPrincipal(loginUser);
        HttpHeaders jwtHeader = getJwtHeader(userPrincipal);
        return new ResponseEntity<>(loginUser,jwtHeader, HttpStatus.OK);
    }


    @PostMapping ("/register")
    public ResponseEntity<User> register(@RequestBody User user) throws UsernameNotFoundException, EmailExistException, UsernameExistException, MessagingException {
        User newUser = userService.register(user.getFirstName(), user.getLastName(), user.getUsername(), user.getEmail());
        return new ResponseEntity<>(newUser, HttpStatus.OK);
    }
    private HttpHeaders getJwtHeader(UserPrincipal userPrincipal) {
        HttpHeaders headers = new HttpHeaders();
        headers.add(JWT_TOKEN_HEADER,jwtTokenProvider.genereteJwtToken(userPrincipal));
        return  headers;
    }

    private void authenticate(String username, String password) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username,password));
    }
}
