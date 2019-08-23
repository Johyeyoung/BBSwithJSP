<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %> 	<!--스크립트파일을 수행할수 있도록 -->

<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content ="text/html; charset=UTF-8">
<mata name = "viewport" content = "width=device-width", initial-scale = "1">
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
	

	int pageNumber = 1; //기본페이지를 의미
	if(request.getParameter("pageNumber") !=null){ //만약 페이지값이 넘어왔다면 그 값을  pageNumber변수에 넣어준다 
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
					 	<li ><a href ="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			
			<%
			}
			%>
		</div>	
	</nav> 
	
	
	<div class = "container">
         <div class="row">
            <table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
               <thead>
                  <tr>
                     <th style="background-color: #eeeeee; text-align: center;">번호</th>
                     <th style="background-color: #eeeeee; text-align: center;">제목</th>
                     <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                     <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                  </tr>
               </thead>
                  <tbody> 	<!--여기가 데이터베이스 내용 출력하는 부분-->

                    <%
                    	BbsDAO bbsDAO = new BbsDAO();
                  		ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                  		
                  		
                    	for(int i= 0;i< list.size();i++){
                    %>		
                    <tr>
                    	<td><%= list.get(i).getBbsID() %></td> 
                    	<td><a href = "view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
                    	<td><%= list.get(i).getUserID() %></td>
                    	<td><%= list.get(i).getBbsDate().substring(0,11) +list.get(i).getBbsDate().substring(11,13)+"시"+  list.get(i).getBbsDate().substring(14,16)+"분" %></td>
                    </tr> 			
                    <% 		
                    	}
                    %>
                  </tbody>
                  </table>
                  
                 <%
                 if(pageNumber != 1){ //1페이지가 아니다 즉 여러페이지라면
                 %>
                 	<a  href= "bbs.jsp?pageNumber=<%=pageNumber-1%>" class ="btn btn-success btn-arrow-left">이전</a> 
                	 <%	  
                 	 } if(bbsDAO.nextPage(pageNumber+1)){
             		 %>
                 		 <a href = "bbs.jsp?pageNumber=<%=pageNumber+1 %>" class = "btn btn-success btn-arrow-left">다음</a>
              	  <% 
                  }
                  %>
                 

                  
                  <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
         </div>
    </div>


		
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body> 
</html>