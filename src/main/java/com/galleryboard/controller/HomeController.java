package com.galleryboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.galleryboard.domain.User;
import com.galleryboard.service.UserService;

@Controller
@RequestMapping("")
public class HomeController {
	@Autowired
	UserService userService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/")
	public String goHome() {
		return "/home";
	}
	
	@GetMapping("/login")
	public String goLogin() {
		return "/login";
	}
	
	@GetMapping("/signUp")
	public String goSignUp() {
		return "/signUp";
	}
	
	@PostMapping("/signUpProcess")
	public String signUpProcess(User user, @RequestParam String adminCheck) {
		String encodePassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePassword);
		user.setAccountNonExpired(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setEnabled(true);
		if("admin".equals(adminCheck)) {
			user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_ADMIN"));
		}else {
			user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		}
		
		userService.registerUser(user); // user 테이블에 만드는 작업 
		userService.createAuthority(user); // auth 테이블에 만드는작업 
		
		return "/login";
	}
	
	@GetMapping("/denied")
	public String goDenied() {
		return "/denied";	
	}
	
}
