
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<mata name = "viewport" content = "width=device-width", initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css"> 
<title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
	String userID = null;//로그인이 된 사람들은 userID라는 변수에 해당 아이디가 담기고 아닌 사람은 null이 담김 , 로그인정보를 담을수 있도록 
	if(session.getAttribute("userID") !=null){//세션이 존재한다면 그 아이디값을 string으로 형변환하여 값을 담는다  
		userID = (String)session.getAttribute("userID");
	}

	int bbsID = 0; //게시글을 불러온다  
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
	Bbs bbs = new BbsDAO().getBbs(bbsID);



	
%>


	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed"
				data-toggle = "collapse" data-target ="#bs-example-navbar-collapse-1"
				aria-expanded = "false">	
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		
		<div class = "callapse navbar-callapse" id="bs-example-navbar-callapse-1">
			<ul class ="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class= "active"><a href = "bbs.jsp">게시판</a></li>
			</ul>
			
			<%
			if(userID ==null){//로그인이 되어있지 않는 경우 보여지는 화면 따로   
			 %>
			<ul class= "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href ="#" class = "dropdown-toggle"
						data-toggle = "dropdown" role ="botton" aria-haspopup="true"
						aria-expanded ="false">접속하기<span class="caret"></span></a>
					<ul class = "dropdown-menu">
					 	<li ><a href ="login.jsp">로그인</a></li>
					 	<li><a href ="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% 	
			}else { //로그인이 되어있는 경우 보여지는 화면 따로
			%>
			<ul class= "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href ="#" class = "dropdown-toggle"
						data-toggle = "dropdown" role ="botton" aria-haspopup="true"
						aria-expanded ="false">회원관리<span class="caret"></span></a>
					<ul class = "dropdown-menu">
					 	<li ><a href ="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			
			<%
			}
			%>
		</div>	
	</nav> 
	
	
	<!--여기서부터 게시판을 구현-->
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style ="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan ="3" style= "background-color: #eeeeee; text-align: center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style = "width: 20%;">글 제목</td>
						<td colspan = "2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")  %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan = "2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan = "2"><%= bbs.getBbsDate().substring(0,11) +bbs.getBbsDate().substring(11,13)+"시"+  bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan = "2" style = "min-height: 200px; tect_align: left;"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href= "bbs.jsp" class = "btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
				<a href = "update.jsp?bbsID=<%=bbsID %>" class = "btn btn-primary">수정</a>		
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "deleteAction.jsp?bbsID=<%=bbsID %>" class = "btn btn-primary">삭제</a>
			<%	
				}
			%>
		</div>
	</div>
		
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body> 
</html>