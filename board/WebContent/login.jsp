<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name ="viewport" content =" width=device-width", initial-scale ="1">
	<!-- viewport =화면상의 표시영역, content =모바일 장치들에 맞게 크기조정, initial =초기화면 배율 설정-->
<link rel = "stylesheet" href= "css/bootstrap.css">
<link rel = "stylesheet" href= "css/custom.css">
<title>게시판</title>
</head>
<body>
	<nav class="navbar navbar-inverse"><!-- navbar =색(inverse=검정 ,default=X) -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
		aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span><!-- 아이콘 이미지 -->
			<span class="icon-bar"></span>
		</button>
		<a class ="navbar-brand" href="main.jsp">게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="board.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right"><!--navbar-raight 는 navbar 가 오른쪽으로 향함. -->
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a><!-- caret=(▼) -->
					<ul class="dropdown-menu">
						<li class="active">
						<!-- active 는 현재의 페이지를 의미 -->
							<a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<!-- 여기까지 로그인 navbar 가 구축이 된것  -->
	<div class="container"> <!-- 하나의 container 로 묶어줌 -->
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;"> <!--jumbotron =큰 상자, pandding-top은 위의 값. -->
				<form method="post" action="loginAction.jsp"> 
				<!-- 하나의 양식 form이 들어감 
					method="post는 어떠한 정보를 숨기면서 보내는것을 의미 
					action="loginAction.jsp 는 login.jsp의 정보(로그인의 정보)를 loginAction.jsp 로 보냄 -->
					<h3 style="text-align: center;">로그인 </h3>
					<!-- text-align:center는 가운데 정렬을 함. -->
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						<!-- placeholder는 어떠한 정보가 입력되지 않았을때 보여주는것 -->
						<!-- class 의 name의 nameID 는 나중에 서버 프로그램을 작성할때 사용하기때문에 잘 하기. -->
						<!-- maxlength는 길이가 너무 길어지지 않도록 20으로 정함. -->
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						<!-- 여기도 똑같이 name="userPassword는 나중에 사용하기에 잘 작성하기  -->
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">

				</form>
			</div>
		<div class="col-lg-4"></div>
		
		</div>
	</div>
	<script src= "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"></script>
	<script src= "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- dropdown 이 안먹힐때 버전 확인해보기. -->
</body>
</html>