<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>
</head>
<body>

	<sec:authentication property="principal" var="user" />

	<h1>글쓰기</h1>
	<form action="/board/registerBoard" method="post" enctype="multipart/form-data">
		<div class="hidden-box">
			<input type="hidden" name="writer" value="${user.name}" />
			<c:if test="${not empty board}">
				<input type="hidden" name="idx" value="${board.idx}" />
			</c:if>
		</div>
		
		<input type="text" name="title" placeholder="제목" />
		<textarea name="content" rows="" cols="" ></textarea>
		
		<c:choose>
			<c:when test="${empty fileList}"> <!-- 저장된 파일이 없는 글쓰기 -->
				<input type="file" onchange="changeFilename(this)" />
				<button type="button" onclick="addFile()">추가</button>
				<button type="button" onclick="removeFile(this)">삭제</button>
			</c:when>
			<c:when test="${not empty fileList}"> <!-- 저장된 파일이 있는 글쓰기 -->
				<c:forEach items="${fileList}" var="item" varStatus="status">
					<input type="hidden" name="fileIdxs" value="${item.idx}" />
					<input type="text" value="${item.originalName}" readonly />
					<input type="file" onchange="changeFilename(this)" />
					<button type="button" onclick="addFile()">추가</button>
					<button type="button" onclick="removeFile(this)">삭제</button>
				</c:forEach>
			</c:when>
		</c:choose>

		
		<div class="btn-box">
			<a href="#"><button type="button">뒤로가기</button></a>
			<input type="submit" value="글쓰기" />
		</div>
	</form>
	
	
	<script>
	
	</script>
	
</body>
</html>