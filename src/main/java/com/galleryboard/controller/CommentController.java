package com.galleryboard.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.javassist.bytecode.stackmap.BasicBlock.Catch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.galleryboard.adapter.GsonLocalDateTimeAdapter;
import com.galleryboard.domain.Comment;
import com.galleryboard.service.CommentService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

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
	}
	

	@RequestMapping(value= {"/","/{idx}"}, method= {RequestMethod.POST, RequestMethod.PATCH})
	public JsonObject registerComment(@PathVariable(value="idx",required = false)Long idx, Comment comment) {
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
	}
	
	@PostMapping("/reply")
	public JsonObject replyComment(Comment comment) {
		/* 답댓글 작성완료를 누르면 form에서 전달해줘야하는것
		   boardIdx , content , writer , ref, step, level, replyYn='Y' 
		*/
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
	}
}
