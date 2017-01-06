package com.mobileleader.tifleader.util;

import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Vector;
import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.TIFFEncodeParam;

public class ImagesToTiff{
	
	public static File saveUploadImages(String path, MultipartFile[] imageList) throws Exception{
		String folderName = "" + System.currentTimeMillis();
		File folderFile = new File(path + "/" + folderName);
		if (!folderFile.exists()){
			folderFile.mkdir();
		}
		if(imageList != null && imageList.length > 0){
			for(MultipartFile image : imageList){
				String fileName = System.currentTimeMillis() + image.getOriginalFilename();
				image.transferTo(new File(folderFile, fileName));
			}
		}
		return folderFile;
	}

	public static String convertImagesToTiff(File file) throws IOException {
		File[] fileList = file.listFiles();
		ArrayList<RenderedImage> list = new ArrayList<RenderedImage>();
		for (int i = 0; i < fileList.length; i++) {
			list.add(ImageIO.read(fileList[i]));
		}
		String tiffFilePath = file.getAbsolutePath() + "\\multiPageImage.tiff";
		OutputStream out = new FileOutputStream(tiffFilePath);
		TIFFEncodeParam param = new TIFFEncodeParam();
		ImageEncoder encoder = ImageCodec.createImageEncoder("TIFF", out, param);
		Vector vector = new Vector();
		for (int i = 1; i < list.size(); i++) {
			vector.add(list.get(i));
		}
		param.setExtraImages(vector.iterator());
		encoder.encode(list.get(0));
		out.close();
		return tiffFilePath;
	}
}
