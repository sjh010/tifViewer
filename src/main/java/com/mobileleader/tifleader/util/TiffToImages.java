package com.mobileleader.tifleader.util;

import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.SeekableStream;

public class TiffToImages{
	public static RenderedImage[] readMultiPageTiff(File file)throws IOException{
	       SeekableStream ss = new FileSeekableStream(file);
	       ImageDecoder decoder = ImageCodec.createImageDecoder("TIFF", ss, null);
	       int numPages = decoder.getNumPages();
	       RenderedImage image[]= new RenderedImage[numPages];
	       for(int i=0;i<decoder.getNumPages();i++){
	           image[i] = decoder.decodeAsRenderedImage(i); 
	       }
	       return image;
	    }
	
	public static void readTiffImage(File file) throws IOException{
		File[] fileList = file.listFiles();
		for(File a : fileList){
			String fileName = a.getName();
			String operator = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
			if(operator.equalsIgnoreCase("tif")||operator.equalsIgnoreCase("tiff")){
				saveReadImage(readMultiPageTiff(a));
				break;
			}
		}
	}
	public static void saveReadImage(RenderedImage[] images) throws IOException{
		for(int i=0; i<images.length; i++){
			ImageIO.write(images[i], "gif", new File("images/splitTiffImages0"+i+".gif"));
		}
	}
}
