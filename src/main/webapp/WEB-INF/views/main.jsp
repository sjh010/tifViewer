<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>tiff Converter</title>
<meta name="description" content="Blueprint: Split Layout" />
<meta name="keywords" content="website template, layout, css3, transition, effect, split, dual, two sides, portfolio" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/demo.css" />
<link rel="stylesheet" type="text/css" href="resources/css/component.css" />
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="sweetalert/sweetalert.min.js"></script>
<script src="resources/modal/jquery.simplemodal.js"></script>
<link rel="stylesheet" type="text/css" href="sweetalert/sweetalert.css">
<script src="resources/js/modernizr.custom.js"></script>
<script type="text/javascript">
	$(function() {
		/* tif 분할 */
		$("#file").on('change', function() {
				//Get count of selected files
				var countFiles = $(this)[0].files.length;
				var imgPath = $(this)[0].value;
				var viewer_area = $("#viewerArea");		
				var tifupload_area = $("#tifUpload");
				if(countFiles > 0){
					var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();						
					if(extn=="tif"||extn=="tiff"){
						swal({
						  title: "파일 분할",
						  text: "올리신 Tiff 파일을 분할하시겠습니까?",
						  type: "info",
						  showCancelButton: true,
						  cancelButtonText : "취소",
						  confirmButtonText: "확인",
						  closeOnConfirm: true
						},
						function(){
							$("#modal_content").modal();
							$("#m_close").click(function(){
								$.modal.close();
							});
							$("#m_confirm").click(function(inputValue){
						    	var select = $("select[name=imageType]").val();
						    	$("#type").val(select);
						    	$("#tifForm").submit();
						    	/* tifupload_area.hide();
						    	viewer_area.show(); */
							});
						});
					}else{
						swal("이미지 타입 오류", "해당 기능은 Tiff 형식만 지원합니다.","error");
					}
				}
		});
		
		/* tif 병합 */
		$("#files").on('change', function() {
			var index = 0;
			//Get count of selected files
			var countFiles = $(this)[0].files.length;
			var fileInfo = document.getElementById("files").files;
			var imgPath = $(this)[0].value;
			var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
			var image_area = $("#imagesArea");		
			var upload_area = $("#imgUpload");
			var infoText;
			var fileName = new Array();
			var fileSize = new Array();
			upload_area.hide();
			if (extn == "gif" || extn == "png" || extn == "jpg"	|| extn == "jpeg") {
				if (typeof (FileReader) != "undefined") {

					//loop for each file selected for uploaded.
					for (var i = 0; i < countFiles; i++) {
						fileName[i] = fileInfo[i].name;
						fileSize[i] = fileInfo[i].size;
						
						var reader = new FileReader();
						reader.onload = function(e) {
							var htmlCode = "<img src='"+ e.target.result + "' class='thumb-image' /></br>";
							infoText =  "<div style='text-align:center;'>파일명 : " + fileName[index] +"</br>파일크기 : "+ fileSize[index]+ "byte</div>";
							image_area.append(htmlCode+infoText);
							index++;
						}
						image_area.show();
						reader.readAsDataURL($(this)[0].files[i]);
					}
					  $("#submitBtn").show();
				} else {
					alert("This browser does not support FileReader.");
				}
			} else {
				alert("Pls select only images");
			}
		});
	});
	
	function tifFileUpClick() {
		$('#file').trigger('click');
	}
	
	function imgFileUpClick() {
		$('#files').trigger('click');
	}
	
	function download(){
		$("#download").submit();
	}
	
	$(document).ready(function() {
        $('#submitBtn').click(function() {
            var data = new FormData();
            $.each($('#files')[0].files, function(i, file) {          
                data.append('file-' + i, file);
            });
            $.ajax({
                url: 'combineAction',
                type: "POST",
                dataType: "text",
                data: data,
                processData: false,
                contentType: false,
                success : function(responseData){
					   $("#filePath").val(responseData);
					   swal("이미지 변환 완료", "업로드 하신 이미지의 변환에 성공했습니다.", "success");
					   $("#submitBtn").hide();
					   $("#downloadBtn").show();
                },
                error: function(jqXHR, textStatus, errorThrown){
                	console.log("upload fail!");
                }
            });
        });
    });

</script>
<style>
.imgUpload{
	width:70%;
	height:350px;
	margin:12% auto;
	border:3px solid #A3B3BB;
	color:#A3B3BB;
	background-image: url('resources/img/imgUploadBg.png');
	background-size: 100% 100%;
	cursor:pointer;
}

/* tif 병합 button css */
.combineBtnBox input[type=button]{
	display:none;
	width: 15%;
	height:45px;
	font-weight: bold;
	padding: 8px;
	color: #A3B3BB;
	border: 3px solid #A3B3BB;
	text-align: center;
	outline: none;
	text-decoration: none;
	transition: background-color 0.2s ease-out, color 0.2s ease-out;
	background-color: rgba( 255, 255, 255, 0);
}

.combineBtnBox input[type=button]:hover, .combineBtnBox input[type=button]:active {
	 background-color: #fff;
	 color: #000;
	 transition: background-color 0.3s ease-in, color 0.3s ease-in;
	 cursor:pointer;
}

/* img 업로드 미리보기 css */
.thumb-image{
	max-height:200px;
	height:expression(this.height>200 ? 200:true);
	width:auto;
	margin: 0 10px 10px 0;
}

#image-holder{
	width: 100%;
	margin : 0 auto;
	display:table;
	vertical-align:middle;
} 

.imgLayer {
	display:table-cell;
	text-align:center;
	vertical-align:middle;
	line-height:0;
	max-height:200px;
	height:expression(this.height>200 ? 200:true);
	width:auto;
	border:1px solid #222222;
	overflow:hidden;
}

.thumb-image img{
	margin : 0 auto;
	display:block;
}

.tifUpload{
	width:70%;
	height:350px;
	margin:12% auto;
	border:3px solid #A3B3BB;
	color:#A3B3BB;
	background-image: url('resources/img/tifUploadBg.png');
	background-size: 100% 100%;
	cursor:pointer;
}

#file, #type {
	display:none;
}

#selectBox, .modal_text {
	margin-top:10%;
}

#selectBox select {
	font-size:20px;
}

#imageType {
	height:45px;
	width:80%;
	margin:15px auto 0px auto;
}

#files {
	display: none;
}

#imagesArea{
	text-align: center;
	display:none;
}


/* modal css */
#m_close {
	background-color:#CDCED0;
	text-align:center;
}

#m_confirm {
	background-color:#8CD4F5;
	text-align:center;
}

#simplemodal-overlay {
	background-color:#000;
	text-align:center;
}

#modal_content{
	display:none;
	margin:0 auto;
	padding-top:1%;
	width:400px;
	height:300px;
	background:white;
	color:black;
	text-align:center;
	border-radius: 15px;
}

.modalBtn {
	width:100%;
	margin:15px auto;
}

.modalBtn input[type=button]{
	width:98px;
	height:60px;
	color:#fff;
	border:0px;
	border-radius: 5px;
	cursor:pointer;
	font-color:white;
	font-size:25px;
	text-align:center;
}

#simplemodal-container{
	left:0;
}

/* thumnail css */
ul, li {
	list-style: none;
}

img {
	border: 0;
}

.thumnail{
	width:100%;
	height:150px;
	background-color:#34495E;
}

.thumnail ul{
	width:100%;
	margin:10% auto;
}


.mini{
	float: left;
	margin: 0 10px 10px 0;
	max-height:100px;
	height:expression(this.height>100 ? 100:true);
	width:auto;
}

#window {
	width:100%;
	clear: both;
	background-color:#ECF0F1;
}

#window img {
	display: block;
	margin: 0 auto;
	padding-left:30px;
	max-height: 500px;
	height: expression(this.height < 500px ? 500px : true);
	width: auto;
}

#imagesArea{
	text-align: center;
}

/* 버튼 css */
.viwerBtnBox button {
	float: right;
	width: 15%;
	height:45px;
	font-weight: bold;
	padding: 8px;
	color: #A3B3BB;
	border: 3px solid #A3B3BB;
	text-align: center;
	outline: none;
	text-decoration: none;
	transition: background-color 0.2s ease-out, color 0.2s ease-out;
	background-color: rgba( 255, 255, 255, 0);
}

.viwerBtnBox button:hover {
	background-color: #fff;
	color: #000;
	transition: background-color 0.3s ease-in, color 0.3s ease-in;
	cursor:pointer;
}

#btnDown{
	margin-right:2%;
}

#btnMain{
	margin-right:5%;
}

</style>
<title>Insert title here</title>
</head>

<body>
	<div class="container">
		<div id="splitlayout" class="splitlayout">
			<div class="intro">
				<div class="side side-left">
					<!-- main 페이지 -->
					<div class="intro-content">
						<div class="profile"><img src="resources/img/tif1.png" alt="profile1"></div>
						<h1><span>TIF 병합</span><span>다수의 이미지를 TIF 파일로 변환</span></h1>
					</div>
					<div class="overlay"></div>
				</div>
				<div class="side side-right">
					<div class="intro-content">
						<div class="profile"><img src="resources/img/tif2.png" alt="profile2"></div>
						<h1><span>TIF 분할</span><span>TIF 파일 업로드</span></h1>
					</div>
					<div class="overlay"></div>
				</div>
			</div><!-- /main -->
			<!-- tif 분할 페이지 -->
			<div class="page page-right">
				<div class="page-inner">
					<form name="tifUploadForm" id="tifForm" action="divideAction" method="post" enctype="multipart/form-data">
						<input type="file" name="file" id="file" accept="image/tiff"/>
							<div class="tifUpload" onclick="tifFileUpClick();"></div>
							<%-- <div id="tif-holder">
								<!-- tif 분할하여 업로드 후 미리보기(viewer) -->
								<div id="viewerLayout">
									<div id="thumnail" class="thumnail">
										<ul id="bx-pager">
											<c:forEach var="item" items="${filePath }">
												<li><a href="<%=request.getContextPath()%>${item}"><img src="<%=request.getContextPath()%>${item}" class="mini"/></a></li>
											</c:forEach>
										</ul>
									</div>
									<div id="window" class="window">
										<img src="<%=request.getContextPath()%>${filePath[0] }" />
										<div class="btnBox">
											<button type="button" class="btnDown" id="btnDown" onclick="download();">Download</button>
										</div>
										<form action="downloadZip" method="get" id="downloadForm">
											<input id="filePath" type="hidden" value="<%=request.getContextPath()%>${filePath[0] }" name="filePath" />
										</form>
									</div>
								</div>
								<!-- tif 분할하여 업로드 후 미리보기(viewer) 끝 -->
								
							</div> --%>
							<input type="hidden" id="type" name="type" />
							<div class="btnConvert">
								<!-- modal content -->
								<div id="modal_content">
									<div id="selectBox">
										<div class="modal_text"><h2>확장자 선택</h2><br/>변환하실 확장자를 선택해주세요.</div>
										<select name="imageType" id="imageType">
											<option value="jpg">jpg</option>
											<option value="png">png</option>
											<option value="gif">gif</option>
										</select>
									</div>
									<div class="modalBtn">
										<input type="button" id="m_close" value="Cancel">
										<input type="button" id="m_confirm" value="OK">
									</div>
								</div>
							<!-- end of modal_centent -->
							</div><!-- /btnConvert -->
					</form>
				</div><!-- /page-inner -->
			</div><!-- /page-right -->
			<!-- tif 병합 페이지 -->
			<div class="page page-left">
				<div class="page-inner">
					<form id="download" action="download">
						<input type="hidden" name="filePath" id="filePath"/>
					</form>
					<form name="imgUploadForm" enctype="multipart/form-data">
						<input type="file" name="file" id="files" accept="image/*" multiple="multiple" />
							<div id="image-holder">
								<p id="imagesArea">
									<div id="imgUpload" class="imgUpload" onclick="imgFileUpClick();"></div>
							</div>
							<div class="combineBtnBox">
								<input type="button" id="submitBtn" class="submitBtn" value="Convert">
								<input type="button" id="downloadBtn" onclick="download();" value="Download">
							</div>
						</form>
				</div><!-- /page-inner -->
			</div><!-- /page-left -->
			<a href="#" class="back back-right" title="back to intro">&rarr;</a>
			<a href="#" class="back back-left" title="back to intro">&larr;</a>
		</div><!-- /splitlayout -->
	</div><!-- /container -->
<script src="resources/js/classie.js"></script>
<script src="resources/js/cbpSplitLayout.js"></script>
</body>
</html>