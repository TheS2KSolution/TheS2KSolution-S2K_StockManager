package com.nanou.authservice.config.service;

import com.nanou.authservice.config.listenerConfig.LoginAttemptService;
import com.nanou.authservice.domain.User;
import com.nanou.authservice.enumeration.enums.AccountStatus;
import com.nanou.authservice.repository.UserRepository;
import com.nanou.authservice.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {
    private final UserService authService;
    private final UserRepository userRepository;
    private final LoginAttemptService loginAttemptService;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user =authService.findUserByUsernameOrEmail(username);
         if(!user.getStatus().equals(AccountStatus.ACTIVATED)) {
             throw new RuntimeException("This account is not activated ");
         }
         else {

              validateLoginAttempt(user);
              user.setLastLoginDateDisplay(user.getLastLoginDate());
              user.setLastLoginDate(new Date());
              userRepository.save(user);
              return new UserPrincipal(user);
          }

    }

    private void validateLoginAttempt(User user) {
        if (user.isNotLocked()) {
            if (loginAttemptService.hasExceededMaxAttempts(user.getUsername())) {
                user.setNotLocked(false);
            } else {
                user.setNotLocked(true);
            }
        } else {
            loginAttemptService.evictUserFromLoginAttemptCache(user.getUsername());
        }
    }


}
