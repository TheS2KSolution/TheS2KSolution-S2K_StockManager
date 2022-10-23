package com.nanou.fullbackend.service;

import com.nanou.fullbackend.domain.User;
import com.nanou.fullbackend.exception.EmailExistException;
import com.nanou.fullbackend.exception.UsernameExistException;

import javax.mail.MessagingException;
import java.util.List;

public interface UserService {
    User register(String firstName,String lastName,String username,String email) throws EmailExistException, UsernameExistException, MessagingException;
    List<User> getUsers();
    User findUserByUsername(String username);
    User findUserByEmail(String email);
}
