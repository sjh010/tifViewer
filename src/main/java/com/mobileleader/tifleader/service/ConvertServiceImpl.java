package com.mobileleader.tifleader.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mobileleader.tifleader.util.ConvertUtil;

@Service
public class ConvertServiceImpl implements ConvertService {

	@Override
	public String imagesToTiff(String serverPath, MultipartFile[] imageList) {
		String resultFilePath = "";
		try {
			resultFilePath = ConvertUtil.combineTiffImage(serverPath, imageList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFilePath;
	}

	@Override
	public ArrayList<String> TiffToImage(String serverPath, MultipartFile tiff, String imageType) {
		ArrayList<String> resultFilePath = null;
		try {
			resultFilePath = ConvertUtil.divideTiffImage( serverPath, tiff, imageType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFilePath;
	}

}
