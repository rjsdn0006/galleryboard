package com.galleryboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.galleryboard.domain.Comment;
import com.galleryboard.service.CommentService;


@RestController
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	@GetMapping("/{boardIdx}")
	public List<Comment> getCommentList(@PathVariable("boardIdx")Long boardIdx, Comment comment) {
		//JsonObject jsonObject = new JsonObject();
		List<Comment> commentList = commentService.getCommentList(boardIdx);
		/*if(CollectionUtils.isEmpty(commentList) == false) {
			Gson gson = new GsonBuilder().registerTypeAdapter(LocalDateTime.class, new GsonLocalDateTimeAdapter()).create();
			JsonArray jsonArr = gson.toJsonTree(commentList).getAsJsonArray();
			jsonObject.add("commentList", jsonArr);
		}*/
		return commentList; 
		// 이중으로 json 변환을 하면 문제가 생기므로 Gson을 쓰지 않는 방법선택
	}
	

	@RequestMapping(value= {"/","/{idx}"}, method= {RequestMethod.POST, RequestMethod.PATCH})
	public String registerComment(@PathVariable(value="idx",required = false)Long idx, Comment comment) {
		// 댓글 작성과 수정이 동시에 이루어진다. 
		String message = "";
		boolean isRegistered = commentService.registerComment(comment);
		if(isRegistered) {
			message = "등록에 성공하였습니다.";
		}else {
			message = "등록에 실패하였습니다.";
		}
		
		return message;
	}
	
	@PostMapping("/delete")
	public String deleteComment(Long idx) {
		String message ="";
		if(idx==null) {
			message = "존재하지 않는 덧글입니다.";
		}else {
			boolean isDeleted = commentService.deleteComment(idx);
			if(isDeleted) {
				message = "삭제가 완료되었습니다.";
			}else {
				message ="삭제에 실패하였습니다.";
			}
		}
		
		return message;
	}
	
	/*
	@PostMapping("/reply")
	public JsonObject replyComment(Comment comment) {
		// 답댓글 작성완료를 누르면 form에서 전달해줘야하는것
		// boardIdx , content , writer , ref, step, level, replyYn='Y' 
		
		JsonObject jsonObject = new JsonObject();
		try {
			boolean isRegistered = commentService.registerComment(comment);
			jsonObject.addProperty("result", isRegistered);
		}catch(DataAccessException e) {
			jsonObject.addProperty("message", "DB처리 과정에 문제가 발생하였습니다.");
		}catch(Exception e) {
			jsonObject.addProperty("message", "시스템에 문제가 발생하였습니다.");
		}
		return jsonObject;
	} */
}
