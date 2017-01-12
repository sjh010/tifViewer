<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<title></title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

ul, li {
	list-style: none;
}

body {
	background-color: #333;
}

img {
	border: 0;
}

#wrap {
	margin: 100px auto;
	width: 640px;
}

#nav li {
	float: left;
}

#nav img {
	width: 70px;
}

#nav a {
	display: block;
	border: 2px solid #bbb;
	margin: 0 6px 10px 0;
	-webkit-border-radius: 5px;
}

#nav a.active {
	border: 2px solid #fff;
}

#window {
	clear: both;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$('#nav a').mouseover(function(e) {
			e.preventDefault();
			$('#nav a').removeClass('active');
			$(this).addClass('active');
			img_url = $(this).attr('href');
			$('#window img').attr('src', img_url);
		});
	})
</script>
</head>
<body>
	<div id="wrap">
		<ul id="nav">
			<li><a href="imgs/lop0.jpg" class="active"><img
					src="imgs/thumb0.jpg" alt="" /></a></li>
			<li><a href="imgs/lop1.jpg"><img src="imgs/thumb1.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop2.jpg"><img src="imgs/thumb2.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop3.jpg"><img src="imgs/thumb3.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop4.jpg"><img src="imgs/thumb4.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop5.jpg"><img src="imgs/thumb5.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop6.jpg"><img src="imgs/thumb6.jpg"
					alt="" /></a></li>
			<li><a href="imgs/lop7.jpg"><img src="imgs/thumb7.jpg"
					alt="" /></a></li>
		</ul>
		<div id="window">
			<img src="imgs/lop0.jpg" alt="" />
		</div>
	</div>

</body>
</html>