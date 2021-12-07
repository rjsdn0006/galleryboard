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
		
		if(comment.getIdx()==null) {
			// 새글을 등록할때 ref값을 1증가시켜준다. 
			int maxRef = commentMapper.findMaxRef(comment.getBoardIdx());
			comment.setRef(maxRef+1);
			queryResult = commentMapper.insertComment(comment);
			
		}else { 
			if(comment.getReplyYn().equals("N")) { // 업데이트를 하는경우라면 
				queryResult = commentMapper.updateComment(comment);

			}else if(comment.getReplyYn().equals("Y")) { // 답글을 다는 경우라면 
				Comment parentComment = commentMapper.selectCommentDetail(comment.getIdx());
				comment.setRef(parentComment.getRef());
				comment.setStep(parentComment.getStep());
				comment.setLevel(parentComment.getLevel());
				comment.setIdx(null);
				commentMapper.adjustCommentLevel(comment);
				queryResult = commentMapper.insertComment(comment);
			}
		}
			
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
