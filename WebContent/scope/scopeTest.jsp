<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>scopeTest.jsp</title>
	</head>
	
	<body>
		<h3>웹페이지의 SCOPE(유효범위)</h3>
		<%
		/* 
		- SCOPE의 종류
			1) page			: 현재 페이지에서만 유효
			2) request		: 서로 연결되어 있는 페이지에서만 유효
			3) session		: 모든 페이지에서 유효 (사용자 개별 접근, 시간)
			4) application	: 모든 페이지에서 유효 (모든 사용자 접근)
			
		- 각 SCOPE의 변수 선언 형식
			1) pageContext.setAttribute("변수명", 값)
			2) request.setAttribute("변수명", 값)
			3) session.setAttribute("변수명", 값)
			4) application.setAttribute("변수명", 값)

		
		- 각 SCOPE의 변수값 얻어오기
			1) pageContext.getAttribute("변수명", 값)
			2) request.getAttribute("변수명", 값)
			3) session.getAttribute("변수명", 값)
			4) application.getAttribute("변수명", 값)

			- 각 SCOPE의 변수 삭제
			1) pageContext.removeAttribute("변수명", 값)
			2) request.removeAttribute("변수명", 값)
			3) session.removeAttribute("변수명", 값)
			4) application.removeAttribute("변수명", 값)
		*/
		//각 SCOPE에 값 올리기
		pageContext.setAttribute("kor", 70);
		request.setAttribute("eng", 90);
		session.setAttribute("mat", 85);
		application.setAttribute("uname", "soldesk");

		//SCOPE 영역의 값 얻어오기
		Object obj=pageContext.getAttribute("kor");
		int kor=(int)obj;
		int eng=(int)request.getAttribute("eng");
		int mat=(int)session.getAttribute("mat");
		String uname=(String)application.getAttribute("uname");
		
		//출력
		out.println("1) pageContext 영역 : "+kor+"<br>");
		out.println("2) request 영역 : "+eng+"<br>");
		out.println("3) session 영역 : "+mat+"<br>");
		out.println("4) application 영역 : "+uname+"<br>");
		
/* 		 //각 SCOPE 변수 삭제
		pageContext.removeAttribute("kor");
		request.removeAttribute("eng");
		session.removeAttribute("mat");
		application.removeAttribute("uname");
		
		out.println("<p>* SCOPE 영역 변수 삭제 후 *</p>");
		out.println("1) pageContext 영역 : "+pageContext.getAttribute("kor")+"<br>");
		out.println("2) request 영역 : "+request.getAttribute("eng")+"<br>");
		out.println("3) session 영역 : "+session.getAttribute("mat")+"<br>");
		out.println("4) application 영역 : "+application.getAttribute("uname")+"<br>"); */
		
		//-------------------------------------------------------------------------------
		
/* 		//request.getAttribute()와 request.getParameter()
		request.setAttribute("aver", 85);
		int aver=(int)request.getAttribute("aver");
		
		//http://172.17.10.8:9090/myweb/test.jsp?aver=70
		int aver=(int)request.getParameter("aver");
		*/
		
		//--------------------------------------------------------------------------------
		
		/* 
		- 페이지 이동
			1) <a href=""></a>
			2) <form action=""></form>
			3) location.href=""
			4) <jsp:forward page=""></jsp:forward>
			5) response.sendRedirect("")
		*/
		
		%>
		<!-- 1)  
		request.getAttribute("eng")는 null값
		<a href="scopeResult.jsp">[Scope 결과 페이지 이동]</a>
		-->
		
		<!-- 2)
		request.getAttribute("eng")는 null값
		 <form action="scopeResult.jsp">
			<button>[Scope 결과 페이지 이동]</button>
		</form>
		 -->
		 <!-- 3) 
		 <script>
		 	alert("SCOPE 결과페이지로 이동합니다");
		 	location.href="scopeResult.jsp";
		 </script>
		  -->
		  
		  <%-- 4)
		  request.getAttribute("eng")는 90접근
		  response.sendRedirect("")사용하는데 제약이 있음
		  <jsp.forward page="scopeResult.jsp"></jsp.forward>
		  --%>
<%
		//5)
		//request.getAttribute("eng")는 null값
		//response.sendRedirect("scopeResult.jsp");
		
		//6)
		//request.getAttribute("eng")는 200
		String view = "scopeResult.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
		
		/* scopeTest.jsp에서 scopeResult.jsp 이동한 경우
		   
					    scopeResult.jsp           그밖의 jsp페이지
			---------------------------------------------------------
			page			  X							 X
			request			  O							 X
			session			  O							 O
			application		  O							 O
			---------------------------------------------------------
		*/
		
		
		
%>
	</body>
</html>