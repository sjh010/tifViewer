package com.mobileleader.tifleader.service;

import org.springframework.web.multipart.MultipartFile;

public interface ConvertService {

	public String imagesToTiff(String path, MultipartFile[] files);
	
	public void tiffToImages();
}
