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
			<li><a href="/board/detail?idx=${item.idx}">${item.title}</a></li>
		</c:forEach>
	</ul>
	<div class="btnDiv">
		<a href="/board/write"><button>글쓰기</button></a>
	</div>
</body>
</html>