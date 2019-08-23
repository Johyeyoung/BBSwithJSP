<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %> <!-- 스크립트파일을 수행할수 있도록  -->
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<mata name = "viewport" content = "width=device-width", initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css"> 
<title>JSP 게시판 웹사이트</title>
</head>
<body>
<%//로그인이 된 사람들은 userID라는 변수에 해당 아이디가 담기고 아닌 사람은 null이 담김 , 로그인정보를 담을수 있도록 
	String userID = null;
	if(session.getAttribute("userID") !=null){//세션이 존재한다면 그 아이디값을 string으로 형변환하여 값을 담는다  
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
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
	}
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
		</div>	
	</nav> 
	
	
	<div class = "container">
		<div class = "row">
		<form method ="post" action = "updateAction.jsp?bbsID=<%= bbsID%>"> <!--form태그를 이용하면 실제로 이 감싸진 부분을 액션페이지(writeAction.jsp)로 내용을 넘기는게 됨 -->
			<table class = "table table-striped" style ="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan ="2" style= "background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type = "text" class = "form-control" placeholder = "글 제목" name ="bbsTitle" maxlength= "50" value = "<%=bbs.getBbsTitle()%>"></td>
					</tr>
					<tr>
						<td><textarea class = "form-control" placeholder = "글 내용" name ="bbsContent" maxlength= "2048" style= "height:350px;"><%=bbs.getBbsContent()%> </textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value = "글수정"> <!--글쓰기버튼 어떠한 데이터를 액션페이지로 보내는 버튼-->
			
		</form>	
		</div>
	</div>
		
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body> 
</html>