package com.galleryboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.galleryboard.domain.Comment;

@Mapper
public interface CommentMapper {
	public int insertComment(Comment comment);
	public int updateComment(Comment comment);
	public int deleteComment(Long idx);
	public Comment selectCommentDetail(Long idx);
	public List<Comment> selectCommentList(Long boardIdx);
	public int selectTotalCommentCount(Long boardIdx);
	public int findMaxRef(Long boardIdx);
	public int adjustCommentLevel(Comment comment);
}
