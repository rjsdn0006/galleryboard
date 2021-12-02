package com.galleryboard.service;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.galleryboard.domain.Board;
import com.galleryboard.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public boolean registerBoard(Board board) {
		int queryResult = 0;
		
		if(board.getIdx() == null) {
			queryResult = boardMapper.insertBoard(board);
		}else {
			queryResult = boardMapper.updateBoard(board);
		}
		
		return (queryResult==1)?true:false;
		
	}

	@Override
	public Board getBoardDetail(Long idx) {
		return boardMapper.selectBoardDetail(idx);
	}

	@Override
	public boolean deleteBoard(Long idx) {
		int queryResult = 0;
		
		Board board = boardMapper.selectBoardDetail(idx);
		if(board!=null && board.getDeleteYn().equals("N")) {
			// board가 비어있지 않거나 삭제되지 않은 글이라면
			queryResult=boardMapper.deleteBoard(idx);
		}
		
		return (queryResult==1)?true:false;
		
	}

	@Override
	public List<Board> getBoardList(Board board) {
		List<Board> list = Collections.emptyList();
		int count = boardMapper.selectBoardTotalCount(board);
		
		if(count>0) {
			list = boardMapper.selectBoardList(board);
		}
		return list;
	}

}
