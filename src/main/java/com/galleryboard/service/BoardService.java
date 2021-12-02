package com.galleryboard.service;

import java.util.List;

import com.galleryboard.domain.Board;

public interface BoardService {
	public boolean registerBoard(Board board);
	public Board getBoardDetail(Long idx);
	public boolean deleteBoard(Long idx);
	public List<Board> getBoardList(Board board);
}
