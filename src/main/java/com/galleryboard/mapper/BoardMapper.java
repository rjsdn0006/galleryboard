package com.galleryboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.galleryboard.domain.Board;

@Mapper
public interface BoardMapper {
	public int insertBoard(Board board);
	public int updateBoard(Board board);
	public Board selectBoardDetail(Long idx);
	public int deleteBoard(Long idx);
	public List<Board> selectBoardList(Board board);
	public int selectBoardTotalCount(Board board);
	public void setTitleImg(@Param("titleImg") String titleImg,@Param("idx") Long idx);
}
