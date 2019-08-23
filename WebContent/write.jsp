<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import ="java.io.PrintWriter" %> //스크립트파일을 수행할수 있도록 

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
	
	
	//여기서부터 게시판을 구현
	<div class = "container">
		<div class = "row">
		<form method ="post" action = "writeAction.jsp"> <!--form태그를 이용하면 실제로 이 감싸진 부분을 액션페이지(writeAction.jsp)로 내용을 넘기는게 됨--> 
			<table class = "table table-striped" style ="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan ="2" style= "background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type = "text" class = "form-control" placeholder = "글 제목" name ="bbsTitle" maxlength= "50"></td>
					</tr>
					<tr>
						<td><textarea class = "form-control" placeholder = "글 내용" name ="bbsContent" maxlength= "2048" style= "height:350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value = "글쓰기"> //글쓰기버튼 어떠한 데이터를 액션페이지로 보내는 버튼
			
		</form>	
		</div>
	</div>
		
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body> 
</html>