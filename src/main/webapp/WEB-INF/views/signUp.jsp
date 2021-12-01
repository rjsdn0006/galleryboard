<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입하기</title>
</head>
<body>

<form action="/signUpProcess" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="text" name="username" placeholder="id" />
	<input type="password" name="password" placeholder="password" />
	<input type="text" name="name" placeholder="이름" />
	<input type="text" name="adminCheck" placeholder="관리자검사" />
	<button type="submit">가입하기</button>
</form>

</body>
</html>