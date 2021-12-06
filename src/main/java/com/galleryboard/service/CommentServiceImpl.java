package com.galleryboard.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.galleryboard.domain.Comment;
import com.galleryboard.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentMapper commentMapper;

	@Override
	public boolean registerComment(Comment comment) {
		int queryResult = 0;
		
		// 새글을 등록할때 ref값을 1증가시켜준다. 
		if(comment.getReplyYn().equals('N')) {
			int maxRef = commentMapper.findMaxRef(comment.getBoardIdx());
			comment.setRef(maxRef+1);
		}else { // 답글을 등록할때 다른 글들의 level값들을 조정해준다.
			commentMapper.adjustCommentLevel(comment);
		}
	
		queryResult = commentMapper.insertComment(comment);
			
		return queryResult==1?true:false;
	}

	@Override
	public boolean deleteComment(Long idx) {
		int queryResult = 0;
		
		Comment comment = commentMapper.selectCommentDetail(idx);
		if(comment.getDeleteYn().equals('Y') || comment==null) {
			return false;
		}
		queryResult =  commentMapper.deleteComment(idx);
		return queryResult==1?true:false;
	}

	@Override
	public Comment getCommentDetail(Long idx) {
		return commentMapper.selectCommentDetail(idx);
	}

	@Override
	public List<Comment> getCommentList(Long boardIdx) {
		List<Comment> commentList = Collections.emptyList();
		
		int commentTotalCount = commentMapper.selectTotalCommentCount(boardIdx);
		if(commentTotalCount>0) {
			commentList = commentMapper.selectCommentList(boardIdx);
		}
		return commentList;
	}

}
