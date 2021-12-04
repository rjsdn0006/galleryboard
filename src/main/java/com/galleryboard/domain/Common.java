package com.galleryboard.domain;

import java.time.LocalDateTime;

import com.galleryboard.paging.Criteria;
import com.galleryboard.paging.PaginationInfo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Common extends Criteria{
	private PaginationInfo paginationInfo;
	private String deleteYn;
	private LocalDateTime insertTime;
	private LocalDateTime updateTime;
	private LocalDateTime deleteTime;
}
