package com.galleryboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.galleryboard.domain.User;
import com.galleryboard.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userMapper.selectUser(username); 
		user.setAuthorities(getAuthorities(username));
		return user;
	}

	public void registerUser(User user) {
		userMapper.insertUser(user);
	}

	public User getUser(String username) {
		return userMapper.selectUser(username);
	}

	public List<GrantedAuthority> getAuthorities(String username) {
		return userMapper.selectAuthorities(username);
	}

	public void createAuthority(User user) {
		userMapper.createAuthority(user);
	}

}
