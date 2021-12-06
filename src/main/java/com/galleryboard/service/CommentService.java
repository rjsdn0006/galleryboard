package com.galleryboard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.galleryboard.domain.Comment;

public interface CommentService {
	public boolean registerComment(Comment comment);
	public boolean deleteComment(Long idx);
	public Comment getCommentDetail(Long idx);
	public List<Comment> getCommentList(Long boardIdx);
}
