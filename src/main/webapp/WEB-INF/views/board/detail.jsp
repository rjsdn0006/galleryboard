<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세화면</title>
</head>
<body>

	<h1>${board.title}</h1>
	<p>${board.content}</p>
	<c:if test="${not empty fileList}"> <!-- 파일을 다운로드 받을 수 있는 영역 -->
		<c:forEach items="${fileList}" var="file" varStatus="status">
			<a href="/board/download?idx=${file.idx}">${file.originalName}</a>
		</c:forEach>
	</c:if>
	
</body>
</html>