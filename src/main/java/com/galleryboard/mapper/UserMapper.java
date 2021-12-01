package com.galleryboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

import com.galleryboard.domain.User;

@Mapper
public interface UserMapper {
	public void insertUser(User user);
	public User selectUser(String username);
	
	public List<GrantedAuthority> selectAuthorities(String username);
	public void createAuthority(User user);
}
