<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

section article {
	display: block;
	position: relative;
	top: 17px;
}

section.backone {
	background-size: auto 100%;
	height: 525px;
	position: relative;
}

/* 썸네일 */
ul,li {
	list-style: none;
}

img {
	border: 0;
}

#wrap {
	margin: 30px auto;
	width: 640px;
	height: auto;
}

#thumnail{
height: 120px;
margin-bottom:20px;

}

#nav li{
	float: left;
	margin: 0 10px 0 0;
	position: relative;
	width: 100px;
	height: 100px;

}

#nav li img {
	max-height:100%;
	height:expression(this.height>50 ? 50:true);
	width:auto;
	display: block;
	margin: 0 auto;
}

#window img {
	display: block;
	margin: 0 auto;
	max-height:300px;
	height:expression(this.height<300px ? 300px:true);
	width:auto;
}

#nav a {
	display: block;
	height: 100px;
	width: 100px;
	margin: 0 auto;
}

#nav a.active {
	display: block;
	border: 2px solid #bbb;
	-webkit-border-radius: 5px;
	margin:0 auto;
	height: 100px;
	width: 100px; 
}

#window {
	clear: both;
}

#btnDown,#btnMain {
	height: 30px;
	width: 80px;
	padding: 15px 7px 7px 25px;
	border: 2px solid green;
	-webkit-border-radius: 5px;
}

#btnDown {
	float:right;
	position:absolute;
	top:400px;
	right:260px;
}

#btnMain {
	float:right;
	position:absolute;
	top:400px;
	right:100px;
}

#btn a {
	color: green;
	text-decoration: none;
}

#btn a:hover {
	text-decoration: underline;
	color: green;
}
</style>
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#nav a').mouseover(function(e) {
			e.preventDefault();
			$('#nav a').removeClass('active');
			$(this).addClass('active');
			img_url = $(this).attr('href');
			$('#window img').attr('src', img_url);
			$('#filePath').val(img_url);
		});
	})
	
	function download(){
		$("#downloadForm").submit();
	}
</script>
</head>
<body>
<div class="content">
		<section class="backone"> <article>
		<div id="wrap">
			<div id="thumnail">
					<ul id="nav">
						<c:forEach var="item" items="${filePath }" >
							<li><a href="<%=request.getContextPath()%>${item}"><img src="<%=request.getContextPath()%>${item}"/></a></li>
						</c:forEach>
					</ul>
			</div>
			<div id="window"><img src="<%=request.getContextPath()%>${filePath[0] }"/>
				<div id="btn">
					<span class="btnMain" id="btnMain"><a href="<%=request.getContextPath()%>/">메인으로</a></span>
					<span class="btnDown" id="btnDown" onclick="download();"><a>다운로드</a></span>
				</div>
				<form action="downloadZip" method="get" id="downloadForm">
					<input id="filePath" type="hidden" name="filePath"/>
				</form>
			</div>
		</div>

		</article> </section>
	</div>
</body>
</html>
<jsp:include page="default/footer.jsp" />