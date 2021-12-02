package com.galleryboard.util;

import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.galleryboard.domain.Attach;

@Component
public class FileUtil {
	private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));
	private final String uploadPath = Paths.get("C:","develop","upload",today).toString();
	private final String getRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	public List<Attach> uploadFiles(MultipartFile[] files,Long boardIdx){
		
	}
}
