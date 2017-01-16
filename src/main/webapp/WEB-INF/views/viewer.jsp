<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="default/header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
* {@import
	url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);font-family:
	'Nanum Barun Gothic ', sans-serif ;
	
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

.footerdiv {
	margin-top: 5%;
	margin-left: 17%;
	height: 5px
}

section.backone {
	background-size: auto 100%;
	height: 100%;
	position: relative;
	margin-top: 5%;
}

/* 썸네일 */
ul, li {
	list-style: none;
}

img {
	border: 0;
}

/* #wrap {
	margin: 30px auto;
	width: 640px;
	height: auto;
} */

.thumnail{
	width:100%;
	margin:0 auto;
}

/*
#thumnail li img{
	margin:0 auto;
}

#nav li {
	float: left;
	margin: 0 10px 0 0;
	position: relative;
	width: 100px;
	height: 100px;
}

#nav img {
	max-height: 100%;
	height: expression(this.height > 50 ? 50 : true);
	width: auto;
	display: block;
	margin: 0 auto;
} */

#window img {
	display: block;
	margin: 0 auto;
	max-height: 300px;
	height: expression(this.height < 300px ? 300px : true);
	width: auto;
}

/* #nav a {
	display: block;
	height: 100px;
	width: 100px;
	margin: 0 auto;
} */

/* #nav a.active {
	display: block;
	border: 2px solid #bbb;
	-webkit-border-radius: 5px;
	margin: 0 auto;
	height: expression(this.height < 300px ? 300px : true);
	width: auto;
} */

#window {
	clear: both;
}

/* 버튼 css */
.btnBox button {
	background: #8CD4F5;
	color: #fff;
	border: none;
	position: relative;
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
	/* position: relative; */
	max-height:100px;
	height:expression(this.height>100 ? 100:true);
	width:auto;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <script type="text/javascript" src="resources/thumnail/jquery.bxslider.min.js"></script> -->
<script type="text/javascript">
	/* $('.bxslider').bxSlider({
		pagerCustom : '#bx-pager'
	});
 */
	$(document).ready(function() {
		$('#bx-pager a').mouseover(function(e) {
			e.preventDefault();
			$('#bx-pager a').removeClass('active');
			$(this).addClass('active');
			img_url = $(this).attr('href');
			$('#window img').attr('src', img_url);
			$('#filePath').val(img_url);
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
					<div id="window">
						<img src="<%=request.getContextPath()%>${filePath[0] }" />
						<div class="btnBox">
							<button type="button" class="btnDown" id="btnDown" onclick="download();" style="float: right; margin-right:5%;">Download</button>
						</div>
						<form action="downloadZip" method="get" id="downloadForm">
							<input id="filePath" type="hidden" value="<%=request.getContextPath()%>${filePath[0] }" name="filePath" />
						</form>
					</div>
				</div>
				<%-- <div id="window2"></div>
				<ul class="bxslider">
					<li><a href="<%=request.getContextPath()%>${filePath[0] }"><img src="<%=request.getContextPath()%>${filePath[0] }" /></a></li>
				</ul>
				</div>
				<div id="bx-pager">
					<c:forEach var="item" items="${filePath }">
						<a href="<%=request.getContextPath()%>${item}"><img src="<%=request.getContextPath()%>${item}" class="mini"/></a> 
					</c:forEach>
				</div> --%>
			</article>
		</section>
	</div>
	<!-- footer  -->
	<div class="footerdiv">
		<jsp:include page="default/footer.jsp" />
	</div>
</body>
</html>