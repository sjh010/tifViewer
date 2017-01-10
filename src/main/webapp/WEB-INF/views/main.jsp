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
	font-family: 'Nanum Barun Gothic ', sans-serif ;
}

section article {
	display: block;
	position: relative;
	top: 17px;
}

section.backone {
	background-size: auto 100%;
	height: 555px;
	position: relative;
}

.jpgToTif {
	display: block;
	height: 300px;
	width: 280px;
	margin: 70px 10px 180px 415px;
	float: left;
	background-image: url('../resources/images/combineBg.png');
	background-size: 100% 100%;
	text-align: center;
}

.tifbg {
	display: block;
	height: 300px;
	width: 280px;
	margin: 70px 415px 180px 10px;
	float: right;
	background-image: url('../resources/images/divideBg.png');
	background-size: 100% 100%;
	text-align: center;
}

.jpgToTifText, .tifbgText {
	font-size: 25px;
	font-weight: bold;
	color: white;
}

.jpgToTif a, .tifbg a {
	font-color: white;
	text-decoration: none;
}

.jpgToTif a:hover, .tifbg a:hover {
	text-decoration: underline;
	color: white;
}

.topText1 {
	margin: 200px 0px 0px 0px;
}

.topText2 {
	margin: 230px 0px 0px 0px;
}
</style>
</head>
<body>
	<div class="content">
		<section class="backone"> <article>
		<div class="jpgToTif">
			<a href="combine.do"><div class="topText1">
					<span class="jpgToTifText">다수의 이미지를<br />TIF 파일로 변환
					</span>
				</div></a>
		</div>
		<div class="tifbg">
			<a href="divide.do"><div class="topText2">
					<span class="tifbgText">TIF 파일 업로드</span>
				</div></a>
		</div>
		</article> </section>
	</div>
</body>
</html>
<jsp:include page="default/footer.jsp" />