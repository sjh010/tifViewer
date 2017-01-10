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

import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.SeekableStream;
import com.sun.media.jai.codec.TIFFEncodeParam;

public class ConvertUtil {
	/**
	 * Service에서 호출하기 위한 Util 접근용 메서드
	 * 
	 * @param String
	 *            serverPath : 서버 내의 실제 디렉토리 경로
	 * @param MultipartFile[]
	 *            imageList : 사용자가 업로드 요청한 파일 리스트
	 * @return 업로드 이미지들을 합쳐서 만든 결과 Tiff 파일의 저장 경로
	 * @exception convertImagesToTiff
	 *                메서드에서 발생하는 IOException
	 */
	public static String combineTiffImage(String serverPath, MultipartFile[] imageList) throws Exception {
		File folderFile = saveUploadImages(serverPath, imageList);
		return convertImagesToTiff(folderFile);
	}

	public static ArrayList<String> divideTiffImage(String serverPath, MultipartFile tiffFile, String fileFormat) throws Exception {
		ArrayList<String> resultFilePath = new ArrayList<String>();
		File folderFile = saveUploadImages(serverPath, tiffFile);
		File savedTiffFile = readTiffImage(folderFile);
		if(savedTiffFile!=null){
			resultFilePath = readMultiPageTiff(savedTiffFile, fileFormat);
		}
		return resultFilePath;
	}

	private static File saveUploadImages(String path, MultipartFile[] imageList) throws Exception {
		String folderName = "" + System.currentTimeMillis();
		File folderFile = new File(path + "/" + folderName);
		if (!folderFile.exists()) {
			folderFile.mkdirs();
		}
		if (imageList != null && imageList.length > 0) {
			for (MultipartFile image : imageList) {
				String fileName = System.currentTimeMillis() + image.getOriginalFilename();
				image.transferTo(new File(folderFile, fileName));
			}
		}
		return folderFile;
	}
	
	private static File saveUploadImages(String path, MultipartFile image) throws Exception {
		String folderName = "" + System.currentTimeMillis();
		File folderFile = new File(path + "/" + folderName);
		if (!folderFile.exists()) {
			folderFile.mkdirs();
		}
		if (image != null) {
			String fileName = System.currentTimeMillis() + image.getOriginalFilename();
			image.transferTo(new File(folderFile, fileName));
		}
		return folderFile;
	}

	private static String convertImagesToTiff(File file) throws IOException {
		File[] fileList = file.listFiles();
		File resultFolder = new File(file.getAbsolutePath() + "/result");
		if(!resultFolder.exists())resultFolder.mkdirs();
		ArrayList<RenderedImage> list = new ArrayList<RenderedImage>();
		for (int i = 0; i < fileList.length; i++) {
			list.add(ImageIO.read(fileList[i]));
		}
		String tiffFilePath = file.getAbsolutePath() + "/result/multiPageImage.tif";
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

	private static ArrayList<String> readMultiPageTiff(File tiffFile, String fileFormat) throws IOException {
		File resultFolder = new File(tiffFile.getParentFile().getAbsolutePath() + "/result");
		if(!resultFolder.exists()) resultFolder.mkdirs();
		SeekableStream ss = new FileSeekableStream(tiffFile);
		ImageDecoder decoder = ImageCodec.createImageDecoder("TIFF", ss, null);
		int numPages = decoder.getNumPages();
		RenderedImage images[] = new RenderedImage[numPages];
		for (int i = 0; i < decoder.getNumPages(); i++) {
			images[i] = decoder.decodeAsRenderedImage(i);
		}
		for (int i = 0; i < images.length; i++) {
			ImageIO.write(images[i], fileFormat, new File(resultFolder, "splitTiffImages" + String.format("%02d", i) + "." + fileFormat));
		}
		
		ArrayList<String> filePathArray = new ArrayList<String>();
		for(File temp : resultFolder.listFiles()){
			filePathArray.add(temp.getAbsolutePath());
		}
		return filePathArray;
	}

	private static File readTiffImage(File file) throws IOException {
		File[] fileList = file.listFiles(new TiffFileNameFilter());
		if(fileList.length==1){
			return fileList[0];
		}
		return null;
	}

}
