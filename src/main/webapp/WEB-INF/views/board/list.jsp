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
			<li><a href="/board/detail${item.makeQueryString(item.currentPageNo)}&idx=${item.idx}">${item.title}</a></li>
			<c:choose>
				<c:when test="${item.titleImg!=noImg}">
					<img src="/resources/${item.titleImg}" />
				</c:when>
			</c:choose>
		</c:forEach>
	</ul>
	
	<div class="searchDiv">
		<form action="/board/list" method="get">
			<input type="hidden" name="currentPageNo" value="1" />
			<input type="hidden" name="recordsPerPage" value="${board.recordsPerPage}" />
			<input type="hidden" name="pageSize" value="${board.pageSize}" />
			<select name="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="wrtier">작성자</option>
			</select>
			<input type="text" name="searchKeyword" placeholder="검색내용" />
			<input type="submit" value="검색하기" />
		</form>
	</div>
	

	
	<c:if test="${board!=null && board.paginationInfo.totalRecordCount>0}">
		<div class="pagination-container">
			<ul class="pagination">
			
				<c:if test="${board.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/board/list','${board.makeQueryString(1)}')">&laquo;</li>
				</c:if>
				<c:if test="${board.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/board/list','${board.makeQueryString(board.firstPage-1)}')">&lsaquo;</li>
				</c:if>
				
				<c:forEach var="i" begin="${board.paginationInfo.firstPage}" end="${board.paginationInfo.lastPage}">
					<c:choose>
						<c:when test="${board.paginationInfo.criteria.currentPageNo == i}">
							<li style="color:red;">${i}</li>
						</c:when>
						<c:when test="${board.paginationInfo.criteria.currentPageNo != i}">
							<li onclick="movePage('/board/list','${board.makeQueryString(i)}')">${i}</li>
						</c:when>
					</c:choose>
				</c:forEach>
				
				<c:if test="${board.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/board/list','${board.makeQueryString(board.lastPage+1)}')">&rsaquo;</li>
				</c:if>
				<c:if test="${board.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/board/list','${board.makeQueryString(board.totalPageCount)}')">&raquo;</li>
				</c:if>
				
			</ul>
		</div>
	</c:if>
	
	
	<div class="btnDiv">
		<a href="/board/write"><button>글쓰기</button></a>
	</div>
	
	<script>
		function movePage(uri, queryString){
			location.href = uri + queryString; 
		}
	</script>
</body>
</html>