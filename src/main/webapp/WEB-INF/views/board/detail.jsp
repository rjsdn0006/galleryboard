<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>상세화면</title>
<style>
	li {
		list-style: none;
	}
	.btn-box{
		margin-bottom : 20px;
	}
	.comment-box{
		margin-bottom : 20px;
	}
</style>
</head>
<body>
	<sec:authentication property="principal" var="principal" />
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
	<hr />
	
	<div class="comment-box">
		<input type="text" name="comment-content" id="comment-content"/>
		<button type="button" onclick="registerComment()">댓글작성</button>
	</div>
	<div class="comment-list">
	</div>
	
	<script>
		function deleteBoard(idx, queryString){
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
				
				htmp += '</form>';
				
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
						commentHtml += ("<span class='c-writer' style='margin-right:10px; font-weight:bold;'>"+comment.writer+"</span>");
						commentHtml += ("<p class='c-content'>"+comment.content+"</p>");
						commentHtml += ("<p>");						
						commentHtml += ("<input type='hidden' name='commentIdx' value='"+comment.idx+"'/>");
						commentHtml += ("<button type='button' onclick='replyComment(this)'>답글</button>");
						commentHtml += ("<button type='button' onclick='deleteComment(this)'>삭제</button>");
						commentHtml += ("<button type='button' onclick='updateComment(this)'>수정</button>");
						commentHtml += ("</p>");
						commentHtml += "</li>";
					});
					
					$('.comment-list').html(commentHtml);
				}
			});
		}
		
		function registerComment(){
			let writer = "${principal.username}";
			let boardIdx = "${board.idx}";
			let content = $("#comment-content").val();
			
			if(content==null || content==""){ // 내용이 비어있다면 입력하라는 경고창출력 
				alert("내용을 입력하세요");
				return false;
			}

			$.ajax({
				url:"/comment/",
				type:"POST",
				data:{boardIdx:boardIdx, content:content, writer:writer}
			}).done(function(message){
				alert(message);
				loadCommentList();	
			});
		}
		
		function updateComment(param){
			let updateBtn = $(param);
			let idx = updateBtn.prevAll('input[name=commentIdx]').val();
			let updateForm = "";
			updateForm += "<div class='updateForm'>";
			updateForm += "<textarea></textarea>";
			updateForm += "<p><button type='button' onclick='updateCommentProcess("+idx+",this)'>수정하기</button>";
			updateForm += "<button type='button' onclick='hideUpdateForm(this)'>취소</button></p>";
			updateForm += "</div>";
			
			updateBtn.after(updateForm);
			updateBtn.toggle();
		}
		
		function updateCommentProcess(idx,param){
			let updateBtn = $(param);
			let content = updateBtn.parent().prev().val();
			if(content==null || content==""){
				alert("내용을 작성해주세요");
				return false;
			}
			let uri = "/comment/"+idx;
			$.ajax({
				url : uri,
				type:"PATCH",
				data:{idx:idx, content:content}
			}).done(function(message){
				alert(message);
				loadCommentList();	
			})
		}
		
		function hideUpdateForm(param){
			let hideBtn = $(param); 
			let updateForm = hideBtn.parent().parent();
			updateForm.prev().toggle();
			updateForm.hide();
			
		}
		function replyComment(param){
			// 답글작성시 replyYn = 'Y' 해주는걸 잊으면 아니됨. 
			let replyBtn = $(param);
			let idx = replyBtn.prevAll('input[name=commentIdx]').val();
			let replyForm = "";
			replyForm += "<div class='replyForm'>";
			replyForm += "<textarea></textarea>";
			replyForm += "<p><button type='button' onclick='replyCommentProcess("+idx+",this)'>답글작성완료</button>";
			replyForm += "<button type='button' onclick='hideReplyForm(this)'>취소</button></p>";
			replyForm += "</div>";
			
			replyBtn.next().next().after(replyForm);
			replyBtn.toggle();
			
		}
		
		function replyCommentProcess(idx,param){
			// 인자로 받아온 idx가 부모의 idx이다. 
			let replyBtn = $(param);
			let content = replyBtn.parent().prev().val();
			if(content==null || content==""){
				alert("내용을 작성해주세요");
				return false;
			}
			let uri = "/comment/reply";
			let boardIdx = "${board.idx}";
			let writer = "${principal.username}";
			let replyYn = "Y";
			$.ajax({
				url : uri,
				type:"POST",
				data:{idx:idx, content:content, boardIdx:boardIdx, writer:writer, replyYn:replyYn}
			}).done(function(message){
				alert(message);
				loadCommentList();	
			})
		}
		
		function hideReplyForm(param){
			let hideBtn = $(param); 
			let replyForm = hideBtn.parent().parent();
			replyForm.prev().prev().prev().toggle();
			replyForm.hide();
		}
		
		function deleteComment(param){
			let deleteBtn = $(param);
			let idx = deleteBtn.prevAll('input[name=commentIdx]').val();
			if(confirm("덧글을 삭제하시겠습니까?")){
				$.ajax({
				url: "/comment/delete",
				data: {idx:idx},
				type:"POST"
				}).done(function(message){
					alert(message);
					loadCommentList();
				});
			}
			
		}
	</script>
	
</body>
</html>