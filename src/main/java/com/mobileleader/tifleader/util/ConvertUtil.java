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
	 * Service에서 호출하기 위한 이미지 병합 메서드
	 * 
	 * @param 	String			: 서버 내의 실제 디렉토리 경로
	 * @param 	MultipartFile[] : 사용자가 Tiff로 병합 요청한 파일 리스트
	 * @return 	String 			: 업로드 이미지들을 병합한 결과 Tiff 파일의 경로 반환
	 * @throws  IOException
	 */
	public static String combineTiffImage(String serverPath, MultipartFile[] imageList) throws IOException {
		File folderFile = saveUploadImages(serverPath, imageList);
		return convertImagesToTiff(folderFile);
	}

	
	/**
	 * Service에서 호출하기 위한 이미지 분할 메서드
	 * 
	 * @param	String 				: 서버 내의 실제 디렉토리 경로
	 * @param 	MultipartFile		: 사용자가 분할 요청한 Tiff 이미지 파일
	 * @param 	String 				: 사용자가 요청한 분할 이미지의 확장자
	 * @return 	ArrayList<String>	: 이미지 분할 후 분할한 이미지들에 대한 경로를 ArrayList로 반환
	 * @throws  IOException
	 */
	public static ArrayList<String> divideTiffImage(String serverPath, MultipartFile tiffFile, String fileFormat) throws IOException {
		ArrayList<String> resultFilePath = new ArrayList<String>();
		File folderFile = saveUploadImages(serverPath, tiffFile);
		File savedTiffFile = readTiffImage(folderFile);
		if(savedTiffFile!=null){
			resultFilePath = readMultiPageTiff( savedTiffFile, fileFormat);
		}
		return resultFilePath;
	}

	/**
	 * 업로드 된 파일을 서버 내부 지정 폴더에 저장하는 메서드
	 * 
	 * @param 	String 			: 서버 내의 실제 디렉토리 경로
	 * @param 	MultipartFile[] : 사용자가 업로드 한 이미지 파일
	 * @return 	File			: 파일 저장 후 해당 파일을 저장한 폴더를 File 형태로 반환
	 * @throws  IOException
	 */
	private static File saveUploadImages(String path, MultipartFile[] imageList) throws IOException {
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
	
	/**
	 * 업로드 된 파일을 서버 내부 지정 폴더에 저장하는 메서드 (오버로드 메서드)
	 * 
	 * @param 	String 			: 서버 내의 실제 디렉토리 경로
	 * @param 	MultipartFile 	: 사용자가 업로드 한 이미지 파일
	 * @return 	File			: 파일 저장 후 해당 파일을 저장한 폴더를 File 형태로 반환
	 * @throws	IOException
	 */
	private static File saveUploadImages(String path, MultipartFile image) throws IOException {
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

	/**
	 * 업로드된 이미지 파일들을 Tiff 파일로 병합하는 메서드
	 * 
	 * @param 	File 	: 사용자가 업로드한 이미지들을 저장한 폴더의 File 객체
ㄴ	 * @return 	String	: 병합한 Tiff 파일의 경로
	 * @throws IOException
	 */
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
		param.setCompression(TIFFEncodeParam.COMPRESSION_DEFLATE);
		param.setDeflateLevel(9);
		param.setExtraImages(vector.iterator());
		encoder.encode(list.get(0));
		out.close();
		return tiffFilePath;
	}
	/**
	 * 서버에 저장한 사용자 요청 Tiff 파일을 읽는 메서드
	 * 
	 * @param 	File 	: 사용자가 업로드한 이미지들을 저장한 폴더의 File 객체
	 * @return 	File	: 해당 폴더의 Tiff파일
	 * @throws	IOException
	 */
	private static File readTiffImage(File file) throws IOException {
		File[] fileList = file.listFiles(new TiffFileNameFilter());
		if(fileList.length==1){
			return fileList[0];
		}
		return null;
	}
	
	/**
	 * Tiff파일을 읽어서 내부의 저장된 이미지들로 다시 분할하는 메서드
	 * 
	 * @param 	File 				: Tiff파일
	 * @param 	String 				: 사용자가 요청한 분할 이미지의 확장자
	 * @return 	ArrayList<String> 	: 이미지 분할 후 분할한 이미지들에 대한 경로를 ArrayList로 반환
	 * @throws	IOException
	 */
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
			String folder = temp.getAbsolutePath().replace("\\", "/");
			String[] path = folder.split("/divide");
			String backPath = path[1];
			System.out.println(backPath);
			String imgSrcPath = "/divideImage"+backPath;
			System.out.println(imgSrcPath);
			filePathArray.add(imgSrcPath);
		}
		return filePathArray;
	}

}
