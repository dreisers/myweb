<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>scopeTest.jsp</title>
	</head>
	
	<body>
		<h3>웹페이지의 SCOPE(유효범위) 결과</h3>
		<%
		out.println("<p>* SCOPE 영역 변수 삭제 후 *</p>");
		out.println("1) pageContext 영역 : "+pageContext.getAttribute("kor"));
		out.println("<hr>");
		out.println("2) request 영역 : "+request.getAttribute("eng"));
		out.println("<hr>");
		out.println("3) session 영역 : "+session.getAttribute("mat"));
		out.println("<hr>");
		out.println("4) application 영역 : "+application.getAttribute("uname"));
		out.println("<hr>");
		%>

	</body>
</html>