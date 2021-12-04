package com.galleryboard.paging;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Criteria {
	private int currentPageNo; // 현재페이지
	private int recordsPerPage; // 페이지당 게시글수 
	private int pageSize; // 화면 하단에 표시할 페이지 사이즈 
	private String searchKeyword; // 검색키워드 
	private String searchType; // 검색유형 
	
	public Criteria() {
		this.currentPageNo = 1;
		this.recordsPerPage = 10;
		this.pageSize = 10; 
	}
	
	public String makeQueryString(int pageNo) {
		// detail 혹은 삭제하기 수행시 기억된 페이지로 이동해야 한다. 
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("currentPageNo", pageNo)
				.queryParam("recordsPerPage", recordsPerPage)
				.queryParam("pageSize", pageSize)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", searchKeyword)
				.build()
				.encode();
		
		return uriComponents.toUriString();
	}
	
	public Map<String, Object> getPagingParams(Criteria criteria){
		Map<String,Object> params = new LinkedHashMap<>();
		params.put("currentPageNo", criteria.getCurrentPageNo());
		params.put("recordsPerPage", criteria.getRecordsPerPage());
		params.put("pageSize", criteria.getPageSize());
		params.put("searchType", criteria.getSearchType());
		params.put("searchKeyword", criteria.getSearchKeyword());
		
		return params;
	}
}
