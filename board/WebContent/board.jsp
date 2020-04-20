<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content =" width=device-width", initial-scale ="1">
	<!-- viewport =화면상의 표시영역, content =모바일 장치들에 맞게 크기조정, initial =초기화면 배율 설정-->
<link rel = "stylesheet" href= "css/bootstrap.css">
	<!-- 스타일시트로 css폴더의 bootstrap.css 사용 -->
<title>게시판</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){ //pageNumber가 매개변수로 넘어왔을 때
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-inverse">
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
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
				<ul class="nav navbar-nav navbar-right"> 
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% 		
				} else {
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<% 		
				}
			%>
		
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
					    <th style="background-color: #eeeeee; text-align: center;">제목</th>
					    <th style="background-color: #eeeeee; text-align: center;">작성자</th>
					    <th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<Board> list = boardDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBoardID() %></td>
						<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>">
						<%= list.get(i).getBoardTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11, 13) +
						"시 " + list.get(i).getBoardDate().substring(14, 16) + "분 "%></td>
					</tr>
					<%	
						}
					%>				
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arrow-left">이전</a>	
			<% 		
				}if(boardDAO.nextPage(pageNumber + 1)){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src= "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"></script>
	<script src= "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>