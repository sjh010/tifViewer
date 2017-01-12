package com.mobileleader.tifleader.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mobileleader.tifleader.service.ConvertService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired
	ConvertService convertService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		return "main";
	}
	
	// 이미지 파일 업로드 페이지 요청
	@RequestMapping(value="/combine", method=RequestMethod.GET)
	public String convert(){
		return "combine";
	}
	
	// 이미지 파일 업로드 및 다운로드
	@RequestMapping(value="/combineAction", method=RequestMethod.POST)
	@ResponseBody
	public String combineAction(HttpSession session, MultipartFile[] files, Model model){
		String path = session.getServletContext().getRealPath("/combine");
		String tiffFilePath = convertService.imagesToTiff(path, files).replace("\\", "/");
		return tiffFilePath;
	}
	
	//so jeong hwan : ajax test
	@RequestMapping(value="/combineAction1", method=RequestMethod.POST)
	@ResponseBody
	public String convert(MultipartHttpServletRequest request, HttpSession session){
	
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
	
	// tiff 파일 업로드 페이지
	@RequestMapping(value="divide", method=RequestMethod.GET)
	public String divide(){
		return "divide";
	}
	
	// tiff -> image 변환 및 뷰어 페이지 반환
	@RequestMapping(value="divideAction", method=RequestMethod.POST)
	public String divideAction(HttpSession session, MultipartFile file, @RequestParam(value="imageType") String imageType, Model model){
		String path = session.getServletContext().getRealPath("/combine");
		ArrayList<String> resultFilePaths = convertService.TiffToImage(path, file, imageType);
		model.addAttribute("filePath", resultFilePaths);
		return "viewer";
	}
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	public ModelAndView download(HttpServletRequest request){
		String filePath = request.getParameter("filePath");
		File tiffFile = new File(filePath);
		return new ModelAndView("download", "downloadFile", tiffFile);
	}
	
}
