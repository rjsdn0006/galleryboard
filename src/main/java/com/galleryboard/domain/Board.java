package com.galleryboard.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board extends Common{
	
	// 갤러리 게시판으로 답글기능을 지원하지 않음
	
	private Long idx;
	private String title;
	private String content;
	private String writer;
	private int viewCnt;
	
	private String changeYn;
	private List<Long> fileidxs;
	
	private String titleImg;
}
