package com.galleryboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.galleryboard.domain.Attach;

@Mapper
public interface AttachMapper {
	public int insertAttach(List<Attach> attach);
	public int deleteAttach(Long boardIdx);
	public int undeleteAttach(List<Long> idxs); 
	public Attach selectAttachDetail(Long idx);
	
	public List<Attach> selectAttachList(Long boardIdx);
	public int selectAttachTotalCount(Long boardIdx);
	
	
}
