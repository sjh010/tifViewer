package com.mobileleader.tifleader.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class CompressUtil {
	
	public static File compression(String path){
		File folderFile = new File(path).getParentFile();
		String zipName = folderFile.getParent() + "/result.zip";
		File[] fileList = folderFile.listFiles();
		byte[] buf = new byte[4096];
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		ZipOutputStream zos = null;
		
		try {
			fos = new FileOutputStream(zipName);
			zos = new ZipOutputStream(fos);
			
			for(int i=0; i< fileList.length; i++){
				FileInputStream in = new FileInputStream(fileList[i]);
				String fileName = fileList[i].getName();
				ZipEntry ze = new ZipEntry(fileName);
				zos.putNextEntry(ze);
				int len;
				while((len = in.read(buf))>0){
					zos.write(buf, 0 , len);
				}
				zos.closeEntry();
				in.close();
			}
			zos.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return new File(zipName);
	}
	
}
