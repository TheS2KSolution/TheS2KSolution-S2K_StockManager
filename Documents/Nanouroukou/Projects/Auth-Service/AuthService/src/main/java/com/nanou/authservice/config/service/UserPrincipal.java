package com.nanou.authservice.config.service;

import com.nanou.authservice.domain.Permission;
import com.nanou.authservice.domain.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@AllArgsConstructor
public class UserPrincipal implements UserDetails {
    private User user;
    private List<GrantedAuthority> authorities;


    public UserPrincipal(User user) {
        authorities = convertPermissionsToAuthorities(user.getRole().getPermissions());
        GrantedAuthority roleAuthority = () -> user.getRole().getRoleName();
        authorities.add(roleAuthority);


    }

    private List<GrantedAuthority> convertPermissionsToAuthorities(Set<Permission> permissions) {
        if (permissions != null) {
            return permissions.stream()
                    .map(permission -> {
                        GrantedAuthority authority = () -> permission.getCode();
                        return authority;
                    }).collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return this.user.getPassword();
    }

    @Override
    public String getUsername() {
        return this.user.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return this.user.isNotLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return this.user.isActive();
    }
}
