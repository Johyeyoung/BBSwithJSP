<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id = "bbs" class = "bbs.Bbs" scope ="page"/> //객체생성 문장 Bbs bbs =  new Bbs(); 

//write.jsp에서  form태그로 감싸서 보낸 내용(property)을 받는 부분
<jsp:setProperty name ="bbs" property ="bbsTitle"/>
<jsp:setProperty name ="bbs" property="bbsContent"/>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null; //이부분은 로그인된 사람과 아닌사람을 구분해주려고 만든것 로그인한 사람은 userID!=null 로그인 안한사람은 userID=null
	if(session.getAttribute("userID")!=null){
		userID =(String) session.getAttribute("userID");
	}
	
	if(userID ==null){ //로그인이 되어있지 않다면  글쓰기를 못함
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href ='login.jsp'");
		script.println("</script>");
	}else {//로그인이 되어있다면
		if( bbs.getBbsTitle()==null || bbs.getBbsContent()==null){ //하나라도 기입하지 않은 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { //다 입력이 된 경우 값을 데이터 베이스에 저장해야됨
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID ,bbs.getBbsContent()); //성공하면 join함수를 이용하여 해당user정보가 등록이 됨 
				
				if(result == -1){//데이터베이스 오류가 발생한 경우 =0이하의 수->데이터베이스에 등록이 되지않음
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {  //0이상의 수는 데이터베이스에 안전하게 등록했다는 뜻
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href= 'bbs.jsp'");
					script.println("</script>");
				}
				
			}
	}
	
	
	
	
	
		
	%>


</body> 
</html>