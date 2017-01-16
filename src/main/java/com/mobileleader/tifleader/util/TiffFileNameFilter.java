package com.mobileleader.tifleader.util;

import java.io.File;
import java.io.FilenameFilter;

public class TiffFileNameFilter implements FilenameFilter {

	@Override
	public boolean accept(File dir, String name) {
		return name.toLowerCase().endsWith(".tif")||name.toLowerCase().endsWith(".tiff");
	}
}
