<%@ page contentType="text/html; charset=UTF-8"%>
<%
	session.removeAttribute("s_admin_id");
	session.removeAttribute("s_admin_pw");
	session.removeAttribute("s_admin_mlevel");
%>
<script>
	location.href = "adminLogin.jsp";
</script>