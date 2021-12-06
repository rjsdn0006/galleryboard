<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
	<div class="btn-box">
		<a href="/board/list${board.makeQueryString(board.currentPageNo)}">뒤로가기</a>
		<a href="/board/write${board.makeQueryString(board.currentPageNo)}&idx=${board.idx}">수정하기</a>
		<button type="button" onclick="deleteBoard(${board.idx}, ${board.makeQueryString(board.currentPageNo)})">삭제하기</button>
	</div>
	
	<div class="comment-box">
		<input type="text" name="comment-content" />
		<button type="button">댓글작성</button>
	</div>
	<div class="comment-list">
	</div>
	
	<script>
		function(idx, queryString){
			if(confirm(idx+"번 게시물을 삭제하겠습니까?")){
				let uri = "/board/delete";
				let html = "";
				
				html += '<form name="dataForm" action="'+uri+'" method="post">';
				html += '<input type="hidden" name="idx" value="'+idx+'" />';
				
				queryString = new URLSearchParams(queryString);
				queryString.forEach(function(value, key) {
					if (value!=null) {
						html += '<input type="hidden" name="' + key + '" value="' + value + '" />';
					}
				});
				
				htmp += '</form>';'
				
			}
		}
		$(function(){
			loadCommentList();	
		});
		
		function loadCommentList(){
			let uri = "/comment/"+"${board.idx}";
			$.ajax({
				url:uri,
				type:"GET"
			}).done(function(result){
				if(result){
					let commentHtml = "";
					$(result).each(function(index, comment){ 
						commentHtml += "<li>";
						commentHtml += ("<span class='c-writer'>"+comment.writer+"</span>");
						commentHtml += ("<span class='c-content'>"+comment.content+"</span>");
						commentHtml += "</li>";
					});
					
					$('.comment-list').html(commentHtml);
				}
			});
		}
	</script>
	
</body>
</html>