<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	<h1>Home</h1>
	
	<div>
		<sec:authorize access="isAnonymous()">
			<a href="/login">로그인</a>
			<a href="/signUp">회원가입</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="principal" />
			<h2>${principal}</h2>
			<a href="/logout">로그아웃</a>
			<a href="/user/info">마이페이지</a>
			<a href="/board/list">게시판</a>
		</sec:authorize>
	</div>
	
</body>
</html>