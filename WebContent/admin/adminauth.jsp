<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="net.utility.*"%>
<%
	//관리자 페이지 로그인 상태 확인 페이지
	String s_id = "";
	String s_pw = "";
	String s_mlevel = "";

	if (session.getAttribute("s_admin_id") == null || session.getAttribute("s_admin_pw") == null
			|| session.getAttribute("s_admin_mlevel") == null) {
		s_id = "guest";
		s_pw = "guest";
		s_mlevel = "guest";
		//로그인하지 않은 경우 관리자 로그인페이지로 자동 이동
		String root = Utility.getRoot();
%>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	<meta charset="UTF-8">
	</head>
	<script>
	 function jumpTo() {
		 alert("로그인페이지로 이동합니다")
		window.top.location.href="<%=root%>/admin/adminLogin.jsp";
	}
	</script>
	<body onload="jumpTo()">
	</body>
	</html>
<%
	} else {
		s_id = (String) session.getAttribute("s_id");
		s_pw = (String) session.getAttribute("s_pw");
		s_mlevel = (String) session.getAttribute("s_mlevel");
	} //if end
%>