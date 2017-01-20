<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/slide/slick-theme.css" />
<link rel="stylesheet" type="text/css" href="resources/slide/slick.css" />
<style>
* {
	@import url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);
	font-family:'Nanum Barun Gothic ', sans-serif ;	
}

html {
	height: 100%;
}

body {
	height: 80%;
}

.content {
	height: auto;
	margin: 0 0 -5px 0;
}

section.backone {
	background-size: auto 100%;
	height: 100%;
	position: relative;
	margin-top: 5%;
}

/* 썸네일 css */
ul, li {
	list-style: none;
}

img {
	border: 0;
}

.thumnail{
	width:600px;
	margin:0 auto;
}

.thumnail ul{
	width:100%;
	margin:0 auto;
}


#window img {
	display: block;
	margin: 0 auto;
	padding-left:30px;
	max-height: 300px;
	height: expression(this.height < 300px ? 300px : true);
	width: auto;
}

#window {
	clear: both;
}

/* 버튼 css */
.btnBox button {
	float: right;
	background: #8CD4F5;
	color: #fff;
	border: none;
	position: relative;
	margin-right:5%;
	height: 60px;
	font-size: 1.6em;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	border-radius: 40px;
}

.btnBox button:hover {
	background: #fff;
	border: 3px solid #8CD4F5;
	color: #8CD4F5;
}

.mini{
	float: left;
	margin: 0 10px 10px 0;
	max-height:100px;
	height:expression(this.height>100 ? 100:true);
	width:auto;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="resources/slide/slick.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#bx-pager a').mouseover(function(e) {
			e.preventDefault();
			$('#bx-pager a').removeClass('active');
			$(this).addClass('active');
			img_url = $(this).attr('href');
			$('#window img').attr('src', img_url);
			$('#filePath').val(img_url);
		});
		
		$('.slider-for').slick({
			  slidesToShow: 1,
			  slidesToScroll: 1,
			  arrows: false,
			  fade: true,
			  asNavFor: '.slider-nav'
			});
		
		$('.slider-nav').slick({
		  slidesToShow: 3,
		  slidesToScroll: 1,
		  asNavFor: '.slider-for',
		  dots: true,
		  centerMode: true,
		  focusOnSelect: true
		});
	})

	function download() {
		$("#downloadForm").submit();
	}
		
</script>
</head>
<body>
	<div class="content">
		<section class="backone">
			<article>
				<div id="wrap">
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
							<a href="/tif"><button type="button" class="btnDown" id="btnMain" onclick="download();" style="margin-right:1%;">Main</button></a>
						</div>
						<form action="downloadZip" method="get" id="downloadForm">
							<input id="filePath" type="hidden" value="<%=request.getContextPath()%>${filePath[0] }" name="filePath" />
						</form>
					</div>
				</div>
			</article>
		</section>
	</div>
</body>
</html>