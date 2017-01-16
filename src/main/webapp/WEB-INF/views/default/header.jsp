<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* @import url(http://fonts.googleapis.com/earlyaccess/hanna.css); */
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css);

.header {
	font-family: 'Nanum Gothic Coding';
	font-weight:bold;
	height: 20%;
	font-size: 100px;
	margin-top: 100px;
	font-weight: 15px;
	text-align:center;
}

a{
text-decoration:none;
}

/* 버튼 css */

button{
  background:#CDCED0;
  color:#fff;
  border:none;
  position:relative;
  height:60px;
  font-size:1.6em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  border-radius: 40px;
}
button:hover{
  background:#fff;
  border : 3px solid #CDCED0;
  color:#CDCED0;
}

#btnMain {
	float:right;
	position:absolute;
	top:100px;
	right:100px;
}

</style>
</head>
<body>
	<div class="header">tiffConverter</div>
	<a href="/tif"><button type="button" id="mainBtn" style="float:right; margin-right:5%;">Main</button></a>
</body>
</html>