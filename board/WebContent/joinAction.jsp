<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- javascript문자 사용하기 위해 씀 -->
<% request.setCharacterEncoding("UTF-8");%><!-- 건너오는 모든 데이터 UTF-8으로  -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- 범위=현재페이지(에서만 사용) -->
<jsp:setProperty name="user" property="userID"/><!-- property들이 모여 useBean id="user"가 됨. -->
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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
		
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserGender() == null ||
			user.getUserName() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 정보가 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		
		if (result == -1) { //primary = userID
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('이미 존재하는 ID입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ 
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		}
	%>
</body>
</html>