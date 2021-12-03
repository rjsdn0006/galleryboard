package com.galleryboard.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.galleryboard.domain.Attach;
import com.galleryboard.exception.AttachFileException;

@Component
public class FileUtil {
	private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));
	private final String uploadPath = Paths.get("C:","develop","upload",today).toString();
	private final String getRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	public List<Attach> uploadFiles(MultipartFile[] files,Long boardIdx){
		
		List<Attach> list = new ArrayList<>();
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
		
		for(MultipartFile file : files) {
			if(file.getSize() < 1) {
				continue;
			}
			try {
				final String extension = FilenameUtils.getExtension(file.getOriginalFilename());
				final String saveName = getRandomString() + "." + extension;
				
				File target = new File(uploadPath, saveName);
				file.transferTo(target);
				
				Attach attach = new Attach();
				attach.setOriginalName(file.getOriginalFilename());
				attach.setSaveName(saveName);
				attach.setSize(file.getSize());
				attach.setBoardIdx(boardIdx);
				list.add(attach);
			}catch(IOException e) {
				throw new AttachFileException("파일 저장에 실패하였습니다.");
			}catch(Exception e) {
				throw new AttachFileException("파일 저장에 실패하였습니다.");
			}
		}
		return list;
	}
}
