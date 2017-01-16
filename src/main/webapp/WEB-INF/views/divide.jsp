<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="default/header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
* {
	@import url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);
	font-family: 'Nanum Barun Gothic ', sans-serif;
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
	/* margin-top:15%; */
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
	/* margin: 100px 10px 50px 350px; */
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

/* 버튼 css */
#submitBtn {
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

/* select css */
#selectBox:after {
	/* content: '<>';
  font: 17px "Consolas", monospace;
  color: #333;
  -webkit-transform: rotate(90deg);
  -moz-transform: rotate(90deg);
  -ms-transform: rotate(90deg);
  transform: rotate(90deg);
  right:11px; */
	/*Adjust for position however you want*/
	top: 18px;
	padding: 0 0 2px;
	border-bottom: 1px solid #999;
	/*left line */
	position: absolute;
	pointer-events: none;
}

#selectBox select {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	/* Add some styling */
	display: block;
	width: 15%;
	max-width: 320px;
	height: 50px;
	/* float: right;
  margin: 5px 0px; */
	/* margin:0 auto; */
	padding: 0px 24px;
	font-size: 16px;
	line-height: 1.75;
	color: #333;
	background-color: #ffffff;
	background-image: none;
	border: 1px solid #cccccc;
	-ms-word-break: normal;
	word-break: normal;
}

</style>
</head>
<body>
	<div class="content">
		<section class="backone">
				<form name="tifUploadForm" action="divideAction" method="post" enctype="multipart/form-data">
					<input type="file" name="file" id="file" accept="image/tiff" style="display:none;"/><!--  style="display:none;" -->
					<div class="tifUpload" onclick=document.all.file.click();>
						<div class="topText1">
							<span class="tifDrop">여기에 TIF 파일 드롭하기</span><br/>
						</div>
						<div class="topText2">
							<span class="tifSelect">파일선택</span>
						</div>
					</div>
					<div class="btnBox">
					<input type="submit" id="submitBtn" value="분할">
					<div id="selectBox">
					<select name="imageType">
					<option selected>확장자 선택</option>
    					<option value="jpg">jpg</option>
    					<option value="png">png</option>
    					<option value="gif">gif</option>
					</select>
					</div>
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