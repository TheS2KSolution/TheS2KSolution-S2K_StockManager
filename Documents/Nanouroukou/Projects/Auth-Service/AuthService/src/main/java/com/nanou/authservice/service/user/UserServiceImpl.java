package com.nanou.authservice.service.user;

import com.nanou.authservice.config.tokenConfig.JwtTokenParams;
import com.nanou.authservice.domain.Role;
import com.nanou.authservice.domain.User;
import com.nanou.authservice.config.service.UserPrincipal;
import com.nanou.authservice.dtos.dtos.ChangePasswordRequestDTO;
import com.nanou.authservice.dtos.dtos.PasswordInitializationRequestDTO;
import com.nanou.authservice.dtos.dtos.RegistrationRequestDTO;
import com.nanou.authservice.dtos.dtos.UserDetailsRequestDTO;
import com.nanou.authservice.enumeration.enums.AccountStatus;
import com.nanou.authservice.exception.domain.EmailNotFoundException;
import com.nanou.authservice.repository.RoleRepository;
import com.nanou.authservice.repository.UserRepository;
import com.nanou.authservice.service.mail.MailService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

import static com.nanou.authservice.messages.UserImplConstant.NO_USER_FOUND_BY_USERNAME;

@Transactional
@RequiredArgsConstructor
@Slf4j
@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtEncoder jwtEncoder;
    private final JwtDecoder jwtDecoder;

    private final JwtTokenParams jwtTokenParams;
    private final MailService mailService;
    @Value("${jwt.issuer}")
    private String issuer;
    private StreamBridge streamBridge;
    @Value("${user.kafka.topic}")
    private String userTopic;
    @Value("${user.photos.path}")
    private String profilePath;


    @Override
    public User addUser(String username, String email, String password, String repassword, boolean emailVerified, String firstName, String lastName, String phone, AccountStatus status) throws MessagingException {
        User user = userRepository.findByUsername(username);
        if (user != null) throw new RuntimeException(String.format("Username %s already exit", username));
        if (!password.equals(repassword)) throw new RuntimeException("Passwords not match");
        user = User.builder()
                .id(UUID.randomUUID().toString())
                .username(username)
                .firstName(firstName)
                .lastName(lastName)
                .phone(phone)
                .email(email)
                .emailVerified(emailVerified)
                .status(status)
                .password(passwordEncoder.encode(password))
                .build();
        userRepository.save(user);
        mailService.sendNewPasswordEmail(lastName, password, email, username);
        return user;
    }

    @Override
    public User updateUserDetails(UserDetailsRequestDTO request) {
        User User = userRepository.findById(request.userId()).orElse(null);
        log.info("===========");
        log.info(request.userId());
        log.info(request.firstName());
        log.info(request.lastName());
        log.info(request.email());
        log.info("===========");
        if (User == null) throw new RuntimeException("User not found");
        if (request.firstName() != null) User.setFirstName(request.firstName());
        if (request.lastName() != null) User.setLastName(request.lastName());
        if (request.email() != null) {
            User.setEmail(request.email());
            User.setEmailVerified(false);
        }
        userRepository.save(User);
        streamBridge.send(userTopic, request);
        return User;
    }

    @Override
    public void changePassword(ChangePasswordRequestDTO request, String userId) {
        User User = userRepository.findById(userId).get();
        if (!passwordEncoder.matches(request.currentPassword(), User.getPassword()))
            throw new RuntimeException("The current password is incorrect");
        if (!request.newPassword().equals(request.confirmPassword())) {
            throw new RuntimeException("Confirmed password not match");
        }
        User.setPassword(passwordEncoder.encode(request.newPassword()));
        userRepository.save(User);
    }

    @Override
    public User findUserByUsername(String username) {
        User User = userRepository.findByUsername(username);
        if (User == null) throw new RuntimeException(String.format("This username %s do not exist", username));
        return User;
    }

    @Override
    public User findUserByUsernameOrEmail(String usernameOrEmail) {
        System.out.println(usernameOrEmail);
        User user = userRepository.findByUsernameOrEmail(usernameOrEmail, usernameOrEmail);
        if (user == null) throw new RuntimeException(NO_USER_FOUND_BY_USERNAME+usernameOrEmail);
        return user;
    }

    @Override
    public boolean isUsernameAvailable(String username) {
        User User = userRepository.findByUsername(username);
        return User == null;
    }

    @Override
    public boolean isEmailAvailable(String email) {
        User User = userRepository.findByEmail(email);
        return User == null;
    }

    private String[] getClaimsFromUser(UserPrincipal userPrincipal) {
        List<String> authorities = userPrincipal.getAuthorities()
                .stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        return authorities.toArray(new String[0]);
    }

    @Override
    public Map<String, String> generateToken(String username, boolean generateRefreshToken) {
        User User = findUserByUsernameOrEmail(username);
        String scope = User.getRole().getPermissions().stream().map(r -> r.getCode()).collect(Collectors.joining(" "));
        Map<String, String> idToken = new HashMap<>();
        Instant instant = Instant.now();
        JwtClaimsSet jwtClaimsSet = JwtClaimsSet.builder()
                .subject(User.getId())
                .issuedAt(instant)
                .expiresAt(instant.plus(generateRefreshToken ? jwtTokenParams.shirtAccessTokenTimeout() : jwtTokenParams.longAccessTokenTimeout(), ChronoUnit.MINUTES))
                .issuer(issuer)
                .claim("scope", scope)
                .claim("email", User.getEmail())
                .claim("firstName", User.getFirstName())
                .claim("lastName", User.getLastName())
                .claim("username", User.getUsername())
                .build();
        String jwtAccessToken = jwtEncoder.encode(JwtEncoderParameters.from(jwtClaimsSet)).getTokenValue();
        idToken.put("access-token", jwtAccessToken);
        if (generateRefreshToken) {
            JwtClaimsSet jwtRefreshClaimsSet = JwtClaimsSet.builder()
                    .subject(User.getId())
                    .issuedAt(instant)
                    .expiresAt(instant.plus(jwtTokenParams.refreshTokenTimeout(), ChronoUnit.MINUTES))
                    .issuer(issuer)
                    .claim("username", User.getUsername())
                    .claim("email", User.getEmail())
                    .build();
            String jwtRefreshTokenToken = jwtEncoder.encode(JwtEncoderParameters.from(jwtRefreshClaimsSet)).getTokenValue();
            idToken.put("refresh-token", jwtRefreshTokenToken);
        }
        return idToken;
    }

    @Override
    public User findUserByUserId(String userId) {
        User User = userRepository.findById(userId).orElse(null);
        if (User == null) throw new RuntimeException(String.format("This username %s do not exist", userId));
        return User;
    }

    @Override
    public User updatePhotoProfile(MultipartFile photoFile, String userId, String baseURL) throws IOException {
        User User = findUserByUserId(userId);
        String photoId = UUID.randomUUID().toString();
        String photoName = userId + "_" + photoId + "_" + photoFile.getOriginalFilename();
        Path photosDirectory = Paths.get(profilePath);
        if (!Files.exists(photosDirectory)) {
            Files.createDirectory(photosDirectory);
        }
        Files.write(Path.of(profilePath, photoName), photoFile.getBytes());
        User.setPhotoFileName(photoName);
        User.setPhotoURL(baseURL + "/photo");
        return userRepository.save(User);
    }

    @Override
    public User register(RegistrationRequestDTO requestDTO, boolean activate) {
        User User = userRepository.findByUsername(requestDTO.username());
        if (User != null) throw new RuntimeException("This username is not available");
        if (!requestDTO.password().equals(requestDTO.confirmPassword()))
            throw new RuntimeException("Passwords not match");
        User = com.nanou.authservice.domain.User.builder()
                .username(requestDTO.username())
                .password(passwordEncoder.encode(requestDTO.password()))
                .firstName(requestDTO.firstName())
                .lastName(requestDTO.lastName())
                .id(UUID.randomUUID().toString())
                .email(requestDTO.email())
                .gender(requestDTO.gender())
                .status(AccountStatus.CREATED)
                .status(activate ? AccountStatus.ACTIVATED : AccountStatus.CREATED)
                .build();
        User savedUser = userRepository.save(User);
        // addRoleToUser(requestDTO.username(),"USER", false);
        verifyEmail(savedUser.getId());
        return User;
    }

    @Override
    public void verifyEmail(String userId) {
        User User = userRepository.findById(userId).get();
        Instant instant = Instant.now();
        JwtClaimsSet jwtClaimsSet = JwtClaimsSet.builder()
                .subject(userId)
                .issuedAt(instant)
                .expiresAt(instant.plus(5, ChronoUnit.MINUTES))
                .issuer(issuer)
                .claim("email", User.getEmail())
                .build();
        String activationJwtToken = jwtEncoder.encode(JwtEncoderParameters.from(jwtClaimsSet)).getTokenValue();
        String emailContent = String.format("To activate yous account click this link : http://localhost:8888/auth-service/public/emailActivation?token=" + activationJwtToken);
        mailService.sendEmail(User.getEmail(), "Email verification", emailContent);
    }

    @Override
    public String emailActivation(String token) {
        try {
            Jwt decode = jwtDecoder.decode(token);
            String subject = decode.getSubject();
            User User = userRepository.findById(subject).get();
            User.setEmailVerified(true);
            User.setStatus(AccountStatus.ACTIVATED);
            userRepository.save(User);
            return "Email verification success";
        } catch (JwtException e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @Override
    public void sendActivationCode(String email) throws EmailNotFoundException {
        User User = userRepository.findByEmail(email);
        if (User == null) throw new EmailNotFoundException(0, "This email is not associated with any account");
        Random random = new Random();
        String activationCode = "";
        for (int i = 0; i < 4; i++) {
            activationCode += random.nextInt(9);
        }
        User.setTemporaryActivationCode(activationCode);
        Instant now = LocalDateTime.now().toInstant(ZoneOffset.UTC);
        User.setTemporaryActivationCodeTimeStamp(now);
        userRepository.save(User);
        mailService.sendEmail(email, "Password Initialization", activationCode);

    }

    @Override
    public void authorizePasswordInitialization(String authorizationCode, String email) {
        User User = userRepository.findByEmail(email);
        if (User == null) throw new RuntimeException("This email is not associated with any account");
        if (!User.getTemporaryActivationCode().equals(authorizationCode))
            throw new RuntimeException("Incorrect authorization code");
        Instant now = LocalDateTime.now().toInstant(ZoneOffset.UTC);
        Instant lastInstant = User.getTemporaryActivationCodeTimeStamp();
        Instant lastInstantPlus5 = lastInstant.plus(5, ChronoUnit.MINUTES);
        if (!now.isBefore(lastInstantPlus5))
            throw new RuntimeException("This authorization code has been expired");
        User.setTemporaryActivationCodeTimeStamp(now);
        userRepository.save(User);
    }

    @Override
    public void passwordInitialization(PasswordInitializationRequestDTO request) {
        if (!request.password().equals(request.confirmPassword()))
            throw new RuntimeException("Passwords not match");
        User User = userRepository.findByEmail(request.email());
        if (User == null) throw new RuntimeException("This email is not associated with any account");
        if (!User.getTemporaryActivationCode().equals(request.authorizationCode()))
            throw new RuntimeException("Incorrect authorization code");
        Instant now = LocalDateTime.now().toInstant(ZoneOffset.UTC);
        Instant lastInstant = User.getTemporaryActivationCodeTimeStamp();
        Instant lastInstantPlus5 = lastInstant.plus(5, ChronoUnit.MINUTES);
        if (!now.isBefore(lastInstantPlus5))
            throw new RuntimeException("This authorization code has been expired");
        User.setPassword(passwordEncoder.encode(request.password()));
        userRepository.save(User);
    }

    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public List<User> searchUsers(String keyWord) {
        return userRepository.findByUsernameContains(keyWord);
    }

    @Override
    public void deleteRole(Long id) {
        this.roleRepository.deleteById(id);
    }

    @Override
    public User activateAccount(boolean value, String userId) {
        AccountStatus status = value ? AccountStatus.ACTIVATED : AccountStatus.DEACTIVATED;
        User User = userRepository.findById(userId).get();
        User.setStatus(status);
        return userRepository.save(User);
    }
}
