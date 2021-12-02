<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h1>게시판</h1>
	<ul>
		<c:forEach items="${boardList}" var="item" varStatus="status">
			<li>${item.title}</li>
		</c:forEach>
	</ul>
</body>
</html>