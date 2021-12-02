package com.galleryboard.domain;

import java.time.LocalDateTime;

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
}
