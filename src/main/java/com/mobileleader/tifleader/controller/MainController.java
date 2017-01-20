package com.mobileleader.tifleader.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mobileleader.tifleader.service.ConvertService;

@Controller
public class MainController {
	
	@Autowired
	ConvertService convertService;
	
//	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	// 메인 페이지 요청
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		return "main";
	}
	
	// 이미지 -> TIF 파일 변환 요청
	@RequestMapping(value="/combineAction", method=RequestMethod.POST)
	@ResponseBody
	public String combineAction(MultipartHttpServletRequest request, HttpSession session){
	
		Iterator<String> itr = request.getFileNames();
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
				
		while(itr.hasNext()){
			MultipartFile mpf = request.getFile(itr.next());
			fileList.add(mpf);
		}
		MultipartFile[] mfileList= fileList.toArray(new MultipartFile[fileList.size()]);
		
		String path = session.getServletContext().getRealPath("/combine");
		String tiffFilePath = convertService.imagesToTiff(path, mfileList).replace("\\", "/");
		
		return tiffFilePath;
	}
	
	// TIF -> image 변환 및 뷰어 페이지 요청
	@RequestMapping(value="divideAction", method=RequestMethod.POST)
	public String divideAction(HttpSession session, MultipartFile file, String type, Model model){
		
		String path = session.getServletContext().getRealPath("/divide");
		System.out.println(path);
		File folder = new File(path);
		if(!folder.exists()) folder.mkdir();
		ArrayList<String> resultFilePaths = convertService.TiffToImage(path, file, type);
		
		model.addAttribute("filePath", resultFilePaths);
		return "viewer";
	}
	
	// TIF 파일 다운로드 요청
	@RequestMapping(value="download", method=RequestMethod.GET)
	public ModelAndView download(HttpServletRequest request){
		String filePath = request.getParameter("filePath");
		File tiffFile = new File(filePath);
		return new ModelAndView("download", "downloadFile", tiffFile);
	}
	
	// 이미지 파일 다운로드 요청
	@RequestMapping(value="downloadZip", method=RequestMethod.GET)
	public ModelAndView downloadDivide(HttpSession session, HttpServletRequest request){
		String serverPath = session.getServletContext().getRealPath("/divide");
		String filePath = request.getParameter("filePath");
		String backPath = filePath.split("/divideImage/")[1];
		File zipFile = convertService.getZipFile(serverPath +"/"+backPath);
		return new ModelAndView("download", "downloadFile", zipFile);
	}
}
