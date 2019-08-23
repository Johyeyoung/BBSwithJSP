<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import ="java.io.PrintWriter" %> <!--스크립트파일을 수행할수 있도록--> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<mata name = "viewport" content = "width=device-width", initial-scale = "1">


<!--특정 css파일 참조  -->
<link rel="stylesheet" href = "css/bootstrap.css"> 
<link rel="stylesheet" href = "css/custom.css"> 



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
				<li class= "active"><a href="main.jsp">메인</a></li>
				<li><a href = "bbs.jsp">게시판</a></li>
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
					 	<li ><a href ="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			
			<%
			}
			%>
		</div>	
	</nav>
	
	<!-- 메인 페이지 디자인 1-->
	<div class = "container">
		<div class ="jumbotron">
			<div class = "container">
				<h1>웹 사이트 소개</h1>
				<p>이 웹사이트는 부트스트랩으로 만든 JSP웹 사이트입니다 최소한의 간단한 로직만을 이용하여 개발하였습니다. 디자인 탬플릿으로는 부트스트랩을 사용하였습니다</p>	
				<p><a class="btn btn-primary btn-pull" href="#" role= "button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	
	<!-- 메인 페이지 디자인 2(with 사진)-->
	<div class ="container"> 
		<div  id = "myCarousel" class = "carousel slide" data-ride="carousel">
			<ol class ="carousel-indicators">
			 	<li data-target ="#myCarousel" data-slide-to="0" class="active"></li>
			 	<li data-target ="#myCarousel" data-slide-to="1" ></li>
			 	<li data-target ="#myCarousel" data-slide-to="2" ></li>
			</ol>
			<div class = "carousel-inner">
				<div class = "item active">
					<img src="images/1.jpg">   <!-- 이미지 주소 넣기 -->
				</div>
				<div class = "item">
					<img src="images/2.jpg">
				</div>
				<div class = "item">
					<img src="images/3.png">
				</div>
			</div>
			
			<!-- 슬라이드 넘기기 화살표 -->
			<a class="left carousel-control" href="#myCarousel" data-slide ="prev">
				<span class = "glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide ="next">
				<span class = "glyphicon glyphicon-chevron-right"></span>
			</a>
			
		</div>
	</div>
	
	
		
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body> 
</html>