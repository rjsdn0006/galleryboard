package com.galleryboard.service;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.galleryboard.domain.Attach;
import com.galleryboard.domain.Board;
import com.galleryboard.mapper.AttachMapper;
import com.galleryboard.mapper.BoardMapper;
import com.galleryboard.util.FileUtil;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	@Autowired
	FileUtil fileUtil;
	@Autowired
	AttachMapper attachMapper;
	
	@Override
	public boolean registerBoard(Board board) {
		int queryResult = 0;
		
		if(board.getIdx() == null) {
			queryResult = boardMapper.insertBoard(board);
		}else {
			queryResult = boardMapper.updateBoard(board);
			if(board.getChangeYn().equals("Y")) {
				attachMapper.deleteAttach(board.getIdx());
				if(CollectionUtils.isEmpty(board.getFileidxs()) == false) {
					attachMapper.undeleteAttach(board.getFileidxs());
				}
			}
		}
		
		return (queryResult==1)?true:false;
		
	}
	
	@Override
	public boolean registerBoard(Board board, MultipartFile[] files) {
		int queryResult = 0;
		
		if(registerBoard(board) == false) {
			return false;
		}
		
		List<Attach> list = fileUtil.uploadFiles(files, board.getIdx()); // 작동함 
		if(CollectionUtils.isEmpty(list) == false) {
			queryResult= attachMapper.insertAttach(list);
			if(queryResult<1) {
				queryResult = 0;
			}
		}
		return (queryResult>0);
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

	@Override
	public List<Attach> getAttachFileList(Long boardIdx) {
		List<Attach> list = Collections.emptyList();
		int count = attachMapper.selectAttachTotalCount(boardIdx);
		if(count>0) {
			list = attachMapper.selectAttachList(boardIdx);
		}
		return list; // 여기서 빈 List가 반환되고있다.
	}

	@Override
	public Attach getAttachDetail(Long idx) {
		return attachMapper.selectAttachDetail(idx);
	}

}
