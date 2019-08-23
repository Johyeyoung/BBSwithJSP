<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="User.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id = "user" class = "User.User" scope ="page"/> // User user = new User(); 의 user(인스턴스)가 id값으로
<jsp:setProperty name ="user" property ="userID"/>
<jsp:setProperty name ="user" property="userPassword"/>
<jsp:setProperty name ="user" property="userName"/>
<jsp:setProperty name ="user" property="userGender"/>
<jsp:setProperty name ="user" property="userEmail"/>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null; //로그인이 이미 된 사람(세션을 부과받은 상태)은 회원가입을 못하게 회원가입페이지에 접속을 차단 (main으로!)
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
	
	
	
	
		if(user.getUserID() ==null || user.getUserPassword()==null || 
			user.getUserName()==null|| user.getUserEmail()==null || user.getUserGender()==null){ //하나라도 기입하지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else { //다 입력이 된 경우
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); //성공하면 join함수를 이용하여 해당user정보가 등록이 됨 
			
			if(result == -1){//데이터베이스 오류가 발생한 경우 = 중복된 아이디를 기입했을떄 ->데이터베이스에 등록이 되지않음
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {  //회원가입 성공 -> 회원가입이 되었을떄는 바로 로그인을 시켜서 메인페이지로 이동하도록
				session.setAttribute("userID",user.getUserID()); //회원가입에 성공하면 세션을 부과한후 메인페이지로 이롱하도록한다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href= 'main.jsp'");
				script.println("</script>");
			}
			
		}
		
	%>


</body> 
</html>