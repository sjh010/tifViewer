<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="default/header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="sweetalert/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="sweetalert/sweetalert.css">
<script src="//oss.maxcdn.com/jquery.form/3.50/jquery.form.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#files").on('change', function() {
					//Get count of selected files
					var countFiles = $(this)[0].files.length;

					var imgPath = $(this)[0].value;
					var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
					var image_area = $("#imagesArea");		
					var upload_area = $("#imgUpload");
					upload_area.hide();
					
					if (extn == "gif" || extn == "png" || extn == "jpg"	|| extn == "jpeg") {
						if (typeof (FileReader) != "undefined") {

							//loop for each file selected for uploaded.
							for (var i = 0; i < countFiles; i++) {

								var reader = new FileReader();
								reader.onload = function(e) {
									//$("<img />", {"src" : e.target.result, "class" : "thumb-image"}).appendTo(image_holder);
									var htmlCode = "<img src='"+ e.target.result + "' class='thumb-image' />";
									image_area.append(htmlCode);
								}

								image_area.show();
								reader.readAsDataURL($(this)[0].files[i]);
							}
							  $("#submitBtn").show();
						} else {
							alert("This browser does not support FileReader.");
						}
					} else {
						alert("Pls select only images");
					}
				});
	});
	function fileUpClick() {
		$('#files').trigger('click');
	}
	
	function download(){
		$("#download").submit();
	}
	
	$(document).ready(function() {
        $('#submitBtn').click(function() {
            var data = new FormData();
            $.each($('#files')[0].files, function(i, file) {          
                data.append('file-' + i, file);
            });
            $.ajax({
                url: 'combineAction',
                type: "POST",
                dataType: "text",
                data: data,
                processData: false,
                contentType: false,
                success : function(responseData){
					   $("#filePath").val(responseData);
					   swal("이미지 변환 완료", "업로드 하신 이미지의 변환에 성공했습니다.", "success");
					   $("#submitBtn").hide();
					   $("#downloadBtn").show();
                },
                error: function(jqXHR, textStatus, errorThrown){
                	console.log("upload fail!");
                }
            });
        });
    });
</script>

<style>
* {@import
	url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);
	font-family: 'Nanum Barun Gothic', sans-serif ;
}

html{
	height: 100%;
}

 body {
	height: 80%;
	margin:0;
}

.content{
height: auto;
 margin:0 0 -5px 0;
}

.footerdiv {
	margin-top:5%;
	margin-left: 17%;
	height:5px
}

section.backone {
	background-size: auto 100%;
	height: 100%;
	position: relative;
	margin-top: 5%;
}

.thumb-image{
	/*display:inline-block;*/
	/* width : 200px; */
	max-height:200px;
	height:expression(this.height>300 ? 300:true);
	width:auto;
}

#image-holder{
width: 100%;
margin : 0 auto;
display:table;
vertical-align:middle;
} 

/*#image-holder { display:table; }*/
.imgLayer {
		display:table-cell;
		text-align:center;
		vertical-align:middle;
		line-height:0;
		max-height:200px;
		height:expression(this.height>300 ? 300:true);
		width:auto;
		border:1px solid #222222;
		overflow:hidden;
	}


 .thumb-image img{
/* width:100%;*/
margin : 0 auto;
display:block;
} 

.imgUpload {
	position: relative;
	display: block;
	height: 250px;
	width: 880px;
	/* margin: 100px 10px 50px 350px; */
	margin : 0 auto;
	background-image: url('resources/images/imgUploadBg.png');
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

/* .btnBox button : not(.submitBtn){
margin-left: 30%;
margin-top:1%;
}

#submitBtn{
margin-left: 45%;
margin-top:1%;
} */

.btnBox button{
margin-left: 45%;
margin-top:1%;
}

/* 버튼 css */

.btnBox button{
  background:#8CD4F5;
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

.btnBox button:hover{
  background:#fff;
  border : 3px solid #8CD4F5;
  color:#8CD4F5;
}



</style>
</head>
<body>
	<div class="content">
		<section class="backone">
		<form id="download" action="download">
			<input type="hidden" name="filePath" id="filePath"/>
		</form>
		<form name="imgUploadForm" enctype="multipart/form-data">
			<input type="file" name="file" id="files" accept="image/*"
				style="display: none;" multiple="multiple" />
			<!-- style="display:none;" -->
			<!--  <img id="blah" src="#" alt="your image" />-->
			<div id="image-holder">
				<p id="imagesArea" style="text-align: center; display:none;" >
				<div id="imgUpload" class="imgUpload" onclick="fileUpClick();">
					<div class="topText1">
						<span class="imgDrop">여기에 이미지 드롭하기</span><br />
					</div>
					<div class="topText2">
						<span class="imgSelect">파일선택</span>
					</div>
				</div>
			</div>
			<div class="btnBox">
			<button type="button" id="submitBtn" class="submitBtn" style="display:none;">Convert</button>
			<button type="button" id="downloadBtn" onclick="download();" style="display:none; ">Download</button>
			<!-- <a href="/tif"><button type="button" id="mainBtn" style="float:right; margin-right:10%;" >Main</button></a> --><!-- style="display:none;" -->
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