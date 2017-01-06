package com.mobileleader.tifleader.service;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

import com.mobileleader.tifleader.util.ImagesToTiff;

public class ConvertServiceImpl implements ConvertService {

	@Override
	public String imagesToTiff(String serverPath, MultipartFile[] imageList) {
		String resultFilePath = "";
		try {
			File folderFile = ImagesToTiff.saveUploadImages(serverPath, imageList);
			resultFilePath = ImagesToTiff.convertImagesToTiff(folderFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFilePath;
	}

	@Override
	public void tiffToImages() {
		// TODO Auto-generated method stub
		
	}
}
