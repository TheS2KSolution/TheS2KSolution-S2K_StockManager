package com.nanou.authservice.ressource.controller;

import com.nanou.authservice.domain.User;
import com.nanou.authservice.dtos.dtos.*;
import com.nanou.authservice.exception.domain.EmailNotFoundException;
import com.nanou.authservice.exception.domain.UserNotFoundException;
import com.nanou.authservice.service.user.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin("*")
@Slf4j
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final JwtDecoder jwtDecoder;
    @Value("${user.photos.path}")
    private String profilePath;

    @PostMapping(value = "/auth")
    public ResponseEntity<Map<String, String>> authentication( AuthRequestDTO authRequestDTO, HttpServletRequest request) throws UserNotFoundException {
        String subject = authRequestDTO.username();
        String grantType = authRequestDTO.grantType();
        System.out.println("donnees"+authRequestDTO);

        if (grantType == null)
            return new ResponseEntity<>(Map.of("errorMessage", "grantType is required"), HttpStatus.UNAUTHORIZED);
        if (grantType.equals("password")) {
            System.out.println("password");
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(subject, authRequestDTO.password())
            );
            subject = authentication.getName();
        } else if (grantType.equals("refreshToken")) {
            Jwt decodedRefreshToken = null;
            decodedRefreshToken = jwtDecoder.decode(authRequestDTO.refreshToken());
            subject = decodedRefreshToken.getClaim("username");

        } else {
            return new ResponseEntity<>(Map.of("errorMessage", String.format("GrantType %s not supported", grantType)), HttpStatus.UNAUTHORIZED);
        }
        Map<String, String> idToken = userService.generateToken(subject, authRequestDTO.withRefreshToken());
        return ResponseEntity.ok(idToken);


    }

    @PutMapping(path = "/user/profile", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @SecurityRequirement(name = "Bearer Authentication")
    public User updatePhotoProfile(
            @RequestParam MultipartFile photoFile,
            Principal principal,
            HttpServletRequest request) throws IOException {
        return this.userService.updatePhotoProfile(photoFile, principal.getName(), request.getRequestURL().toString());
    }

    @GetMapping(value = "/user/profile/photo", produces = {MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_JPEG_VALUE})
    @SecurityRequirement(name = "Bearer Authentication")
    public byte[] getUserPhoto(Principal principal) throws IOException {
        User user = userService.findUserByUserId(principal.getName());
        Path path = Paths.get(profilePath, user.getPhotoFileName());
        return Files.readAllBytes(path);
    }

    @GetMapping(value = "/public/profile/photo/{userId}", produces = {MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_JPEG_VALUE})
    @SecurityRequirement(name = "Bearer Authentication")
    public byte[] getPublicPhoto(@PathVariable String userId) throws IOException {
        User user = userService.findUserByUserId(userId);
        if (user.getPhotoFileName() == null) {
            ClassPathResource classPathResource = new ClassPathResource("static/images/up.jpeg");
            return Files.readAllBytes(classPathResource.getFile().toPath());
        } else {
            Path path = Paths.get(profilePath, user.getPhotoFileName());
            return Files.readAllBytes(path);
        }
    }

    @GetMapping(path = "/user/profile")
    @SecurityRequirement(name = "Bearer Authentication")
    public User getUserProfile(Principal principal) {
        return this.userService.findUserByUserId(principal.getName());
    }

    @GetMapping("/public/isUsernameAvailable")
    public boolean isUsernameAvailable(String username) {
        return userService.isUsernameAvailable(username);
    }

    @GetMapping("/public/isEmailAvailable")
    public boolean isEmailAvailable(String email) {
        log.info(email);
        return userService.isEmailAvailable(email);
    }

    @PostMapping(path = "/public/register")
    public User register(@RequestBody RegistrationRequestDTO requestDTO) {
        return this.userService.register(requestDTO, false);
    }

    @GetMapping(path = "/public/emailActivation")
    public String emailActivation(String token) {
        return this.userService.emailActivation(token);
    }

    @PostMapping(path = "/public/forgotPassword")
    public ResponseEntity<Map<String, String>> forgotPassword(String email) {
        try {
            this.userService.sendActivationCode(email);
            return ResponseEntity.ok(Map.of("message", "The activation code has been sent to " + email));
        } catch (EmailNotFoundException e) {
            return new ResponseEntity<>(Map.of("errorMessage", e.getMessage()), HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("errorMessage", "Internal Error"), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping(path = "/public/requestForPasswordInit")
    public ResponseEntity<Map<String, String>> authorizePasswordInitialization(String authorizationCode, String email) {
        try {
            this.userService.authorizePasswordInitialization(authorizationCode, email);
            return ResponseEntity.ok(Map.of("message", "Your account has been activated successfully"));
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("errorMessage", e.getMessage()), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/public/passwordInitialization")
    public void passwordInitialization(PasswordInitializationRequestDTO request) {
        this.userService.passwordInitialization(request);
    }


    @GetMapping(path = "/admin/users")
    @PreAuthorize("hasAuthority('SCOPE_ADMIN')")
    public List<User> usersList() {
        return userService.getAllUsers();
    }

    @GetMapping(path = "/admin/searchUsers")
    @PreAuthorize("hasAuthority('SCOPE_ADMIN')")
    public List<User> searchUsers(String keyWord) {
        return userService.searchUsers(keyWord);
    }


    @PutMapping(path = "/admin/updateUserDetails")
    @PreAuthorize("hasAuthority('SCOPE_USER')")
    @SecurityRequirement(name = "Bearer Authentication")
    public User updateUser(@RequestBody UserDetailsRequestDTO requestDTO) {
        return this.userService.updateUserDetails(requestDTO);
    }

    @PutMapping("/admin/changePassword")
    public void changerPassword(@RequestBody ChangePasswordRequestDTO request, Principal principal) {
        this.userService.changePassword(request, principal.getName());
    }

    @PutMapping("/admin/verifyEmail")
    public void verifyEmail(Principal principal) {
        this.userService.verifyEmail(principal.getName());
    }

    @PutMapping("/admin/activateAccount")
    public User activateAccount(@RequestBody ActivateAccountRequestDTO request) {
        return this.userService.activateAccount(request.value(), request.userId());
    }
}
