package com.nanou.authservice.service.user;

import com.nanou.authservice.domain.Role;
import com.nanou.authservice.domain.User;
import com.nanou.authservice.dtos.dtos.ChangePasswordRequestDTO;
import com.nanou.authservice.dtos.dtos.PasswordInitializationRequestDTO;
import com.nanou.authservice.dtos.dtos.RegistrationRequestDTO;
import com.nanou.authservice.dtos.dtos.UserDetailsRequestDTO;
import com.nanou.authservice.enumeration.enums.AccountStatus;
import com.nanou.authservice.exception.domain.EmailNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public interface UserService {
    User addUser(String username, String email, String password, String repassword, boolean emailVerified, String firstName, String lastName, String phone, AccountStatus status) throws MessagingException;

    User updateUserDetails(UserDetailsRequestDTO request);


    User findUserByUsername(String username);

    User findUserByUserId(String userId);

    User findUserByUsernameOrEmail(String usernameOrEmail);

    boolean isUsernameAvailable(String username);

    Map<String, String> generateToken(String username, boolean generateRefreshToken);

    User updatePhotoProfile(MultipartFile photoFile, String userId, String baseURL) throws IOException;

    User register(RegistrationRequestDTO requestDTO, boolean activate);

    void verifyEmail(String userId);

    String emailActivation(String token);

    void sendActivationCode(String email) throws EmailNotFoundException;

    void authorizePasswordInitialization(String authorizationCode, String email);

    void passwordInitialization(PasswordInitializationRequestDTO request);

    List<Role> getAllRoles();

    List<User> getAllUsers();

    void deleteRole(Long id);

    void changePassword(ChangePasswordRequestDTO request, String name);

    boolean isEmailAvailable(String email);

    User activateAccount(boolean value, String userId);

    List<User> searchUsers(String keyWord);

    //Role requestForRoleToUserAttribution(String username, String roleName);

}
