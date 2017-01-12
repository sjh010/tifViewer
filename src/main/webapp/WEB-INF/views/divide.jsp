<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

section article {
	display: block;
	position: relative;
	top: 17px;
}

section.backone {
	background-size: auto 100%;
	height: 455px;
	position: relative;
}

.tifUpload {
	position:relative;
	display: block;
	height: 250px;
	width: 880px;
	margin: 100px 10px 50px 350px;
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

</style>
</head>
<body>
	<div class="content">
		<section class="backone">
			<article>
				<form name="tifUploadForm" action="divideAction" method="post" enctype="multipart/form-data">
					<input type="file" name="file" id="file" /><!--  style="display:none;" -->
					<div class="tifUpload" onclick=document.all.file.click();>
						<div class="topText1">
							<span class="tifDrop">여기에 TIF 파일 드롭하기</span><br/>
						</div>
						<div class="topText2">
							<span class="tifSelect">파일선택</span>
						</div>
					</div>
					<input type="submit" id="submitBtn" value="분할">
					<select name="imageType">
    					<option value="">확장자 선택</option>
    					<option value="png">png</option>
    					<option value="jpg">jpg</option>
    					<option value="gif">gif</option>
					</select>
				</form>
				
			</article>
		</section>
	</div>
</body>
</html>
<jsp:include page="default/footer.jsp" />