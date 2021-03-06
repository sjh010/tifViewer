<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="default/header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="sweetalert/sweetalert.min.js"></script>
<script src="resources/modal/jquery.simplemodal.js"></script>
<link rel="stylesheet" type="text/css" href="sweetalert/sweetalert.css">
<script type="text/javascript">
	$(function() {
		$("#file").on('change', function() {
				//Get count of selected files
				var countFiles = $(this)[0].files.length;
				var imgPath = $(this)[0].value;
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
							});
						});
					}else{
						swal("이미지 타입 오류", "해당 기능은 Tiff 형식만 지원합니다.","error");
					}
				}
		});
	});

</script>
<style>
* {
	@import url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);
	font-family:'Nanum Barun Gothic ', sans-serif;
}
html {
	height: 100%;
}

body {
	height: 80%;
	margin:0;
}

.content{
	height: 60%;
	 margin:0 0 -5px 0;
}

.footerdiv {
	margin-left: 17%;
	height:5px
}

section.backone {
	background-size: auto 100%;
	height: 100%;
	position: relative;
	margin-top: 5%;
}

.tifUpload {
	position: relative;
	display: block;
	height: 250px;
	width: 880px;
	margin: 0 auto;
	background-image: url('resources/images/tifUploadBg.png');
	background-size: 100% 100%;
	text-align: center;
}

.tifUpload:hover {
	cursor:pointer;
}

.tifDrop,.tifSelect {
	font-size: 25px;
	font-weight: bold;
	color: white;
}

.tifDrop:hover, .tifSelect:hover {
	color : white;
	text-decoration : underline;
	cursor:pointer;
}

.tifDrop{
	position:absolute;
	bottom:70px;
	right:300px;
}

.tifSelect {
	position:absolute;
	bottom:30px;
	right:400px;
}

.btnBox{
	margin-left: 40%;
	margin-top:3%;
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

/* 버튼 css */
#submitBtn{
	float: left;
	background: #8CD4F5;
	color: #fff;
	border: none;
	position: relative;
	height: 60px;
	font-size: 1.6em;
	margin: 0 auto;
	margin-right:35px;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	border-radius: 40px;
}

#submitBtn:hover {
	background: #fff;
	border : 3px solid #8CD4F5;
	color: #8CD4F5;
}

#submitBtn:before,#submitBtn:after {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #8CD4F5;
	transition: 400ms ease all;
}

#submitBtn:after {
	right: inherit;
	top: inherit;
	left: 0;
	bottom: 0;
}

#submitBtn:hover:before,#submitBtn:hover:after {
	width: 100%;
	transition: 800ms ease all;
}

#m_close {
	background-color:#CDCED0;
	text-align:center;
}

#m_confirm {
	background-color:#8CD4F5;
	text-align:center;
}

/* modal css */
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
	border:none;
	border-radius: 5px;
	cursor:pointer;
	font-color:white;
	font-size:25px;
	text-align:center;
}

#simplemodal-container{
	left:0;
}
</style>
</head>
<body>
	<div class="content">
		<section class="backone">
				<form id="tifForm" name="tifUploadForm" action="divideAction" method="post" enctype="multipart/form-data">
					<input type="file" name="file" id="file" accept="image/tiff" />
					<div class="tifUpload" onclick="document.all.file.click();">
						<div class="topText1">
							<span class="tifDrop">여기에 TIF 파일 드롭하기</span><br/>
						</div>
						<div class="topText2">
							<span class="tifSelect">파일선택</span>
						</div>
					</div>
					<input type="hidden" id="type" name="type" />
					<div class="btnBox">
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
					</div>
				</form>
		</section>
	</div>
	<!-- footer  -->
	<div class="footerdiv">
		<jsp:include page="default/footer.jsp" />
	</div>
</body>
</html>