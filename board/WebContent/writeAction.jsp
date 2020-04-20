<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/> <!-- 하나의 게시글 인스턴스 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<%
		String userID = null;
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else { //로그인된 상황
			if(board.getBoardTitle() == null || board.getBoardContent() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력되지 않은 정보가 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
				
				if (result == -1) { //글쓰기 실패
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{ 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
	
		
		}
	%>
</body>
</html>