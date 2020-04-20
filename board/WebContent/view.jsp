<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name ="viewport" content =" width=device-width", initial-scale ="1">
	<!-- viewport =화면상의 표시영역, content =모바일 장치들에 맞게 크기조정, initial =초기화면 배율 설정-->
<link rel = "stylesheet" href= "css/bootstrap.css">
	<!-- 스타일시트로 css폴더의 bootstrap.css 사용 -->
<title>게시판</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int boardID = 0;
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		Board board = new BoardDAO().getboard(boardID);
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
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">글</th>
	
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style = "width: 20%;">제목</td> 
							<td colspan="2"> <%=board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
									.replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>	
							<td>작성자</td>
							<td colspan="2"> <%=board.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일</td>
							<td colspan="2"> <%=board.getBoardDate().substring(0, 11) + board.getBoardDate().substring(11, 13) +
									"시 " + board.getBoardDate().substring(14, 16) + "분 "%></td>
						</tr> 
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"> <%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td> <!-- 특수문자 , 공백 처리 -->
						</tr>
					</tbody>
				</table>
				<a href="board.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID != null && userID.equals(board.getUserID())){ //글 작성자라면 수정,삭제 가능
				%>
						<a href="update.jsp?boardID=<%= boardID %>" class="btn btn-primary">수정</a>	
						<a href="deleteAction.jsp?boardID=<%= boardID %>" class="btn btn-primary">삭제</a>	
				<%
					}
				%>
		</div>
	</div>
	<script src= "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"></script>
	<script src= "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>