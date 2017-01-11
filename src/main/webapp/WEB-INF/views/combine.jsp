<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="default/header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
$(function() {
    $("#file").on('change', function(){
        document.getElementById("imgUpload").style.display = "none";
    	readURL(this);
    });


function readURL(input) {
    if (input.files.length>0) {
    	var htmlCode = "";
    	$.each(input.files, function(i, v){
    		var reader = new FileReader();
    	    reader.onload = function () {
    	        //    $('#blah').attr('src', e.target.result);
    	      reader.readAsDataURL(v);
    	      var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
    	        tempImage.src = reader.result; //data-uri를 이미지 객체에 주입
    	        tempImage.onload = function() {
    	            //리사이즈를 위해 캔버스 객체 생성
    	            var canvas = document.createElement('canvas');
    	            var canvasContext = canvas.getContext("2d");
    	            
    	            //캔버스 크기 설정
    	            canvas.width = 100; //가로 100px
    	            canvas.height = 100; //세로 100px
    	            
    	            //이미지를 캔버스에 그리기
    	            canvasContext.drawImage(this, 0, 0, 100, 100);
    	            //캔버스에 그린 이미지를 다시 data-uri 형태로 변환
    	            var dataURI = canvas.toDataURL("image/jpeg");
    	            
    	            htmlCode += "<img src='"+dataURI +"' width='100'/>";
    	        }
    	    }
    	});
    	$("#previewArea").append(htmlCode);
    }
}

});
</script>

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
	height: 455px;
	position: relative;
}

.imgUpload {
	position: relative;
	display: block;
	height: 250px;
	width: 880px;
	margin: 100px 10px 50px 350px;
	background-image: url('../resources/images/imgUploadBg.png');
	background-size: 100% 100%;
	text-align: center;
}

.imgUpload:hover {
	cursor: pointer;
}

.imgDrop, .imgSelect {
	font-size: 25px;
	font-weight: bold;
	color: white;
}

.imgDrop:hover, .imgSelect:hover {
	color: white;
	text-decoration: underline;
	cursor: pointer;
}

.imgDrop {
	position: absolute;
	bottom: 70px;
	right: 310px;
}

.imgSelect {
	position: absolute;
	bottom: 30px;
	right: 400px;
}
</style>
</head>
<body>
	<div class="content">
		<section class="backone"> <article>
		<form name="imgUploadForm" action="combineAction" method="post"
			enctype="multipart/form-data">
			<input type="file" name="file" id="file" multiple="multiple" />
			<!-- style="display:none;" -->
			<!--  <img id="blah" src="#" alt="your image" />-->
			<div id="previewArea"></div>
			<div id="imgUpload" class="imgUpload"
				onclick=document.all.file.click()>
				<div class="topText1">
					<span class="imgDrop">여기에 이미지 드롭하기</span><br />
				</div>
				<div class="topText2">
					<span class="imgSelect">파일선택</span>
				</div>
			</div>
		</form>
		</article> </section>
	</div>
</body>
</html>
<jsp:include page="default/footer.jsp" />