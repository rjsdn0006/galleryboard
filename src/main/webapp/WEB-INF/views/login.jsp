<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

<form action="/loginProcess" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="text" name="username" placeholder="id" />
	<input type="password" name="password" placeholder="password" />
	<input type="checkbox" name="remember-me" id="remember-me" />로그인유지
	<button type="submit">로그인</button>
</form>

</body>
</html>