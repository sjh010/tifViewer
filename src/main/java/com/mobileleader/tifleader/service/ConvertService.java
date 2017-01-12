package com.mobileleader.tifleader.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

public interface ConvertService {

	public String imagesToTiff(String path, MultipartFile[] files);
	
	public ArrayList<String> TiffToImage( String serverPath, MultipartFile tiff, String imageType);
	
}
