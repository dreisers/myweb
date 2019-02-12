<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//auth.jsp
	//로그인 상태 확인 페이지
	String s_id = "guest";
	String s_passwd = "guest";
	String s_mlevel = "guest";

	if (session.getAttribute("s_id") == null ||
		session.getAttribute("s_passwd") == null ||
		session.getAttribute("s_mlevel") == null) {
		s_id = "guest";
		s_passwd = "guest";
		s_mlevel = "guest";
	} else {
		s_id = (String) session.getAttribute("s_id");
		s_passwd = (String) session.getAttribute("s_passwd");
		s_mlevel = (String) session.getAttribute("s_mlevel");
	} //if end
%>