package com.galleryboard.domain;

import java.time.LocalDate;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User implements UserDetails{
	
	private String username;
	private String password;
	private String name;
	private LocalDate registerDate;
	
	// 보안관련 --------------------------------------------------
	private static final long serialVersionUID = 1L;
	private String auth;
	private Collection<? extends GrantedAuthority> authorities;
	private boolean isAccountNonExpired;
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired;
	private boolean isEnabled;
	
	@Override
	public String getUsername() {
		return username;
	}
	// --------------------------------------------------------
	
}
