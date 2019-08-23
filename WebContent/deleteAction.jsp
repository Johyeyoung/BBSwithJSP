
<!-- writeAction페이지와 비슷하므로 그걸 복사 대신 빈즈부분은 없앴음 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %> 
<% request.setCharacterEncoding("UTF-8");%>




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
	}
	
	int bbsID = 0; //현재글이 유효한 글인지를 체크하고 게시글을 불러온다  
	if(request.getParameter("bbsID") != null){//매개변수로 넘어온 bbsID가 존재한다면  
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	if(bbsID ==0){ //게시글이 없다면 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID); //자신이 이전에 작성했던 정보가 담겨져있는 객체를 생성
	
	if(!userID.equals(bbs.getUserID())){ 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}else {//성공적으로 권한이 있는 사람이라면 //여기서는 자바빈즈를 사용하는 writeAction페이지와 달리 update페이지에서 form을 통해 넘어오는 파라미터값을 받아서 비교하는 식으로
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(bbsID); //이부분이 writerAction부분과 다름
			if(result == -1){//데이터베이스 오류가 발생한 경우 =0이하의 수->데이터베이스에 등록이 되지않음
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {  //성공적으로 삭제하면 다시 게시판 목록을 보여준다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href= 'bbs.jsp'");
				script.println("</script>");
			}
	}

		
	%>


</body> 
</html>