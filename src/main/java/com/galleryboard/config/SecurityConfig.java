package com.galleryboard.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.galleryboard.service.UserService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	@Autowired private UserService userService;
	@Autowired private DataSource dataSource;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	public void configure(HttpSecurity http) throws Exception{
		http
	      .authorizeRequests() // 승인요청 
	      		.antMatchers("/board/**").authenticated()
	            .antMatchers("/user/**").authenticated() 
                                       // 해당 url의 요청은 인증되야한다.
	            .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
                                       // 해당 url의 요청은 해당 권한이 있어야한다. 
	            .anyRequest().permitAll() 
                                       // 다른 모든 요청들은 인증이나 권한없이 허용
	            .and()
	      .formLogin()
	            .loginPage("/login") // login.jsp 에서의 정보를 가져옴 
	            .loginProcessingUrl("/loginProcess") // 로그인처리 로직을 수행하는 곳
	            .defaultSuccessUrl("/", true) // 성공시 이동페이지 
	            .permitAll()
	            .and()
	      .logout()
	         .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
	         .logoutSuccessUrl("/")
	         .invalidateHttpSession(true)
	         .deleteCookies("JSESSIONID", "remember-me")
	         .and()
	      .rememberMe() // 로그인을 기억하는 역할 
	         .key("myWeb")
	         .rememberMeParameter("remember-me")
	         .tokenValiditySeconds(86400)//1일
	         .and()
	      .exceptionHandling()
	         .accessDeniedPage("/denied") // 접근이 제한될경우 보여줄 페이지 
	         .and()
	      .sessionManagement()
	         .sessionCreationPolicy(SessionCreationPolicy.NEVER) // 세션사용정책   
	         .invalidSessionUrl("/login")
	         .and()
	      .csrf().disable(); // 개발시에는 .csrf().disable()로 멈춰주는것이 편하다.   
	}
	
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
		db.setDataSource(dataSource);
		return db;
	}
	
	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception{
		auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
	}

}
