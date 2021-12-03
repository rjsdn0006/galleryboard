package com.galleryboard.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.galleryboard.domain.Attach;
import com.galleryboard.domain.Board;

public interface BoardService {
	public boolean registerBoard(Board board);
	public boolean registerBoard(Board board,MultipartFile[] files,String path);
	public Board getBoardDetail(Long idx);
	public boolean deleteBoard(Long idx);
	public List<Board> getBoardList(Board board);
	public List<Attach> getAttachFileList(Long boardIdx);
	public Attach getAttachDetail(Long idx);
}
