<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>

	<sec:authentication property="principal" val="user" />

	<h1>글쓰기</h1>
	<form action="/board/registerBoard" method="post">
		<div class="hidden-box">
			<input type="hidden" name="writer" value="${user.name}" />
			<c:if test="${not empty board}">
				<input type="hidden" name="idx" value="${board.idx}" />
			</c:if>
		</div>
		
		<input type="text" name="title" placeholder="제목" />
		<textarea name="content" rows="" cols="" ></textarea>
		
		<div class="btn-box">
			<a href="#"><button type="button">뒤로가기</button></a>
			<input type="submit" value="글쓰기" />
		</div>
	</form>
	
</body>
</html>