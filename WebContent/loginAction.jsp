<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="User.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %> //스크립트파일을 수행할수 있도록 
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id = "user" class = "User.User" scope ="page"/>

//login.jsp의 form으로 감싸진 내용 중 name부분을=> Action페이지의 property가 같은이름으로 받는다 
<jsp:setProperty name ="user" property ="userID"/>
<jsp:setProperty name ="user" property="userPassword"/>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<% 
		String userID = null; //로그인이 이미 된 사람(세션을 부과받은 상태)은 로그인페이지에 접속하지 못하도록(main으로!) 
		if(session.getAttribute("userID")!=null){
			userID =(String) session.getAttribute("userID");
		}
		if(userID !=null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href ='main.jsp'");
			script.println("</script>");

		}
	
	
		//여기서 부터는 데이터베이스에 login함수로 접근한 결과값을 가지고 상황에 맞는 걸 웹액션으로 짜주기 
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){ //로그인에 성공한경우
			session.setAttribute("userID",user.getUserID()); //로그인에 성공하면 세션을 부과 이걸로 나중에 로그아웃도 시킬수있음 빼앗아서
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href ='main.jsp'");
			script.println("</script>");
			
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>


</body> 
</html>