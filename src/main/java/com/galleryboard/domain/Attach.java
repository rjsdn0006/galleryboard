package com.galleryboard.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Attach extends Common{
	private Long idx;
	private Long boardIdx;
	private String orginalName;
	private String saveName;
	private long size;
}
