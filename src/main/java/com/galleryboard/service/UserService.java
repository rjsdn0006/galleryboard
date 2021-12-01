package com.galleryboard.service;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.galleryboard.domain.User;

public interface UserService extends UserDetailsService {
	public void registerUser(User user);
	public User getUser(String username);
	
	public List<GrantedAuthority> getAuthorities(String username);
	public void createAuthority(User user);
}
