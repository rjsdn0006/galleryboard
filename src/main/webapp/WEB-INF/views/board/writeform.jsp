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
<style>
	.title{
		width:500px;
		padding:5px;
	}
	.content{
		width:500px;
		height:300px;
		padding:5px;
	}
	
	.fileDiv{
		margin-bottom:5px;
	}
	
	#btnDiv{
		margin-top : 20px;
	}
</style>
</head>
<body>

	<sec:authentication property="principal" var="user" />

	<h1>글쓰기</h1>
	<form action="/board/registerBoard" method="post" enctype="multipart/form-data">
		<div class="hidden-box">
			<input type="hidden" name="writer" value="${user.username}" />
			<c:if test="${not empty board}"> <!-- 수정작업일 경우 보내줄요소 -->
				<input type="hidden" name="idx" value="${board.idx}" />
				<input type="hidden" id="changeYn" name="changeYn" value="N"/>
			</c:if>
		</div>
		
		<p><input type="text" name="title" placeholder="제목" class="title"/></p>
		<p><textarea name="content" class="content"></textarea></p>
		
		<c:choose>
			<c:when test="${empty fileList}"> <!-- 저장된 파일이 없는 글쓰기 -->
				<div data-name="fileDiv" class="fileDiv">
					<!-- <label for="file_0">파일</label> -->
					<div>
						<input type="text" class="upload-name" value="파일찾기" readonly />
						<label for="file_0" class="control-label">찾아보기</label>
						<input type="file" name="files" id="file_0" class="upload-hidden" onchange="changeFilename(this)" style="display:none" />
						<button type="button" onclick="addFile()">추가</button>
						<button type="button" onclick="removeFile(this)">삭제</button>
					</div>
				</div>
			</c:when>
			<c:when test="${not empty fileList}"> <!-- 저장된 파일이 있는 글쓰기 -->
				<div data-name="fileDiv" class="fileDiv">
					<c:forEach items="${fileList}" var="item" varStatus="status">
						<!--<label for="file_${status.index}">파일${status.count}</label>-->
						<div>
							<input type="hidden" name="fileIdxs" value="${item.idx}" />
							<input type="text" class="upload-name" value="${item.orginalName}" readonly />
							<label for="file_${status.index}" class="control-label">찾아보기</label>
							<input type="file" name="files" id="file_${status.index}" class="upload-hidden" onchange="changeFilename(this)" style="display:none"/>
							<c:if test="${status.first}">
								<button type="button" onclick="addFile()">추가</button>
							</c:if>
							<button type="button" onclick="removeFile(this)">삭제</button>
						</div>
					</c:forEach>
				</div>
			</c:when>
		</c:choose>

		
		<div id="btnDiv">
			<a href="#"><button type="button">뒤로가기</button></a>
			<input type="submit" value="글쓰기" />
		</div>
	</form>
	
	
	<script>
		const fileList = "${fileList}";
		let fileIdx = (fileList==null) ? 0 : fileList.length; // 파일의 인덱스를 이미 존재하는 인덱스 다음번호를 매겨주기 위하여 
		
		function addFile(){ // 파일추가 버튼을 눌렀을 경우 
			console.log(fileIdx);
			const fileDivs = $("div[data-name='fileDiv']"); 
			if(fileDivs.length>2){
				alert("파일업로드는 최대 세개까지 가능합니다.");
				return false;
			}
			
			document.getElementById("changeYn").value = "Y";
			fileIdx++;
			
			const fileHtml = `
				<div data-name="fileDiv" class="fileDiv">
					<!--<label for="file_${fileIdx}">파일</label>-->
					<div>
						<input type="text" class="upload-name" value="파일찾기" readonly />
						<label for="file_${fileIdx}" class="control-label">찾아보기</label>
						<input type="file" name="files" id="file_${fileIdx}" class="upload-hidden" onchange="changeFilename(this)" style="display:none"/>
						
						<button type="button" onclick="removeFile(this)">삭제</button>
					</div>
				</div>
			`;
			
			$('#btnDiv').before(fileHtml);
		}
		
		function removeFile(elem){
			document.getElementById("changeYn").value = "Y";
			
			const prevTag = $(elem).prev().prop("tagName");
			if(prevTag === "BUTTON"){ // 첫번째 파일만 해당하겠다. 
				const file = $(elem).prevAll('input[type="file"]');
				const fileName = $(elem).prevAll('input[type="text"]');
				file.val('');
				fileName.val('파일찾기');
				
				$(elem).prevAll('input[name="fileIdxs"]').remove();
				return false;
			}
			
			const target = $(elem).parents('div[data-name="fileDiv"]'); // 2,3번째 파일은 그냥 div를 날려버리면 된다. 
			target.remove();
		}
		
		 function changeFilename(file){
			document.getElementById("changeYn").value = "Y";
			
			file = $(file);
			const filename = file[0].files[0].name; 
			const target = file.prevAll("input.upload-name");
			target.val(filename);
			
			file.prevAll('input[name="fileIdxs"]').remove();
			//fileIdxs는 이미 업로되 있던 파일들의 idx를 의미한다. 이걸 지워줘야지만 새로운 파일만 업로드 기능을 거친다. 
		}
	</script>
	
</body>
</html>