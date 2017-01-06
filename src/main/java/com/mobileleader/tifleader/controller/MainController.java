package com.mobileleader.tifleader.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mobileleader.tifleader.service.ConvertService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Inject
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
	public String combineAction(@RequestParam("image") MultipartFile[] imageList,
									HttpServletRequest request, Model model){
		
		String root = request.getSession().getServletContext().getRealPath("/");
		
		String filePath = convertService.imagesToTiff(imageList, root);
		
		model.addAttribute("filePath", filePath);
		
		return null;
	}
	
	// tiff 파일 업로드 페이지
	@RequestMapping(value="divide", method=RequestMethod.GET)
	public String divide(){
		
		return "divide";
	}
	
	// tiff -> image 변환 및 뷰어 페이지 반환
	@RequestMapping(value="divideAction", method=RequestMethod.POST)
	public String divideAction(){
		
		return "viewer";
	}
	
	@RequestMapping(value="download", method=RequestMethod.POST)
	public String download(){
		
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
