package com.mobileleader.tifleader.util;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;

public class TiffFileNameFilter implements FilenameFilter {
	/**
	 * 업로드 된 파일을 서버 내부 지정 폴더에 저장하는 메서드 (오버로드 메서드)
	 * 
	 * @param 	File 		: 이름을 검사할 파일들이 위치한 폴더 파일
	 * @param 	String 		: 폴더 내의 파일의 이름
	 * @return 	boolean		: 정의한 조건과 적합한지에 대한 boolean 값
	 */
	@Override
	public boolean accept(File dir, String name) {
		return name.toLowerCase().endsWith(".tif")||name.toLowerCase().endsWith(".tiff");
	}
}
