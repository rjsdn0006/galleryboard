package com.galleryboard.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Comment extends Common{
	private Long idx;
	private Long boardIdx;
	private String content;
	private String writer;
	private int ref;
	private int step;
	private int level;
	private String replyYn;
}
