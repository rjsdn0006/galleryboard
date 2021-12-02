package com.galleryboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.galleryboard.domain.Board;
import com.galleryboard.service.BoardService;
import com.galleryboard.util.Method;
import com.galleryboard.util.UiUtil;

@Controller
@RequestMapping("/board")
public class BoardController extends UiUtil {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/write")
	public String goWrite(@RequestParam(value="idx",required=false) Long idx, Model model) {
		if(idx == null) {
			model.addAttribute("board",new Board());
		}else {
			Board board = boardService.getBoardDetail(idx);
			if(board==null) {
				return "redirect:/board/list";
			}
			model.addAttribute("board", board);
		}
		
		return "/board/writeForm";
	}
	
	@PostMapping("/registerBoard")
	public String registerBoard(Board board,Model model) {
		try {
			boolean isRegistered = boardService.registerBoard(board);
			if(isRegistered==false) {
				return showMessageWithRedirect("게시글 등록실패","/board/list",Method.GET,null,model);
				// null 에는 paging param이 들어간다. 
			}
		}catch(DataAccessException e) {
			return showMessageWithRedirect("DB영역의 문제발생","/board/list",Method.GET,null,model);
		}catch(Exception e) {
			return showMessageWithRedirect("시스템영역의 문제발생","/board/list",Method.GET,null,model);
		}
		return showMessageWithRedirect("게시글이 등록되었습니다.","/board/list",Method.GET,null,model);
		
	}
	
	
}
