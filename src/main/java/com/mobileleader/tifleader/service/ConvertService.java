package com.mobileleader.tifleader.service;

import org.springframework.web.multipart.MultipartFile;

public interface ConvertService {

	public String imagesToTiff(MultipartFile[] imageList, String path);
	
	public String[] TiffToImage(MultipartFile tiff, String imageType);
	
	public void download();
	
	
	
	
	
}
