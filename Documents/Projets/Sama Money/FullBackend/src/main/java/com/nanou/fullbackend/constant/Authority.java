package com.nanou.fullbackend.constant;

public class Authority {
    public static final String[] USER_AUTHORITIES = {"user:read"};
    public static final String[] HR_AUTHORITIES = {"user:red","user:update"};
    public static final String[] MANAGER_AUTHORITIES = {"user:red","user:update"};
    public static final String[] ADMIN_AUTHORITIES = {"user:red","user:create","user:update"};
    public static final String[] SUPER_ADMIN_AUTHORITIES = {"user:red","user:create","user:update","user:delete"};
}