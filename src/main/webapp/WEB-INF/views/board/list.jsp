<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>
<title>게시판</title>
</head>
<body> 
	<h1>게시판</h1>
	<ul>
		<c:forEach items="${boardList}" var="item" varStatus="status">
			<li><a href="/board/detail?idx=${item.idx}">${item.title}</a></li>
			<c:choose>
				<c:when test="${item.titleImg!=noImg}">
					<img src="/resources/${item.titleImg}" />
				</c:when>
			</c:choose>

		</c:forEach>
	</ul>
	<div class="btnDiv">
		<a href="/board/write"><button>글쓰기</button></a>
	</div>

</body>
</html>