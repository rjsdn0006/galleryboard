package com.galleryboard.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.galleryboard.domain.Attach;
import com.galleryboard.domain.Board;
import com.galleryboard.service.BoardService;
import com.galleryboard.util.Method;
import com.galleryboard.util.UiUtil;

@Controller
@RequestMapping("/board")
public class BoardController extends UiUtil {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/list")
	public String goList(Board board,Model model) {
		List<Board> boardList = boardService.getBoardList(board);
		model.addAttribute("boardList",boardList);
		return "/board/list";
	}
	
	@GetMapping("/detail")
	public String goDetail(Board params, @RequestParam(value="idx", required=false)Long idx, Model model) {
		if(idx==null) {
			showMessageWithRedirect("잘못된 요청입니다", "/board/list", Method.GET, null, model);
		}
		Board board = boardService.getBoardDetail(idx);
		if(board==null || board.getDeleteYn().equals("Y")) {
			showMessageWithRedirect("없거나 이미 삭제된 게시물입니다.", "/board/list", Method.GET, null, model);
		}
		model.addAttribute("board",board);
		
		List<Attach> fileList = boardService.getAttachFileList(idx);
		model.addAttribute("fileList",fileList);
		return "/board/detail";
	}
	
	@GetMapping("/write")
	public String goWrite(@RequestParam(value="idx",required=false) Long idx, Model model) {
		if(idx == null) {
			model.addAttribute("board",new Board());
		}else {
			Board board = boardService.getBoardDetail(idx);
			if(board==null || board.getDeleteYn().equals("Y")) {
				return showMessageWithRedirect("존재하지 않는 게시글 입니다", "/board/list", Method.GET, null, model);
			}
			model.addAttribute("board", board);
			
			List<Attach> fileList = boardService.getAttachFileList(idx);
			model.addAttribute("fileList", fileList);
		}
		
		return "/board/writeform";
	}
	
	@PostMapping("/registerBoard")
	public String registerBoard(Board board,MultipartFile[] files,Model model) {
		try {
			boolean isRegistered = boardService.registerBoard(board, files);
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
	
	@GetMapping("/download")
	public void downloadAttachFile(@RequestParam(value="idx", required = false)Long idx, Model model, HttpServletResponse response) {
		if(idx==null) throw new RuntimeException("올바르지 않은 접근입니다.");
		// 여기서의 idx는 attach의 idx를 의미한다. 
		Attach fileInfo = boardService.getAttachDetail(idx);
		if(fileInfo == null || fileInfo.getDeleteYn().equals("Y")) {
			throw new RuntimeException("파일 정보를 찾을 수 없습니다.");
		}
		String uploadDate = fileInfo.getInsertTime().format(DateTimeFormatter.ofPattern("yyMMdd"));
		String uploadPath = Paths.get("C:","develop","upload",uploadDate).toString();
		String fileName = fileInfo.getOriginalName();
		File file = new File(uploadPath, fileInfo.getSaveName());
		
		try {
			byte[] data = FileUtils.readFileToByteArray(file);
			response.setContentType("application/octet-stream");
			response.setContentLength(data.length);
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8"));
			response.getOutputStream().write(data);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}catch(IOException e) {
			throw new RuntimeException("파일 다운로드에 실패하였습니다.");
		}catch(Exception e) {
			throw new RuntimeException("시스템에 문제가 생겼습니다.");
		}
	}
	
	
}
