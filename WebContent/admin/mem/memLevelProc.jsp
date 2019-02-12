<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>memLevelProc.jsp</title>
</head>
<body>
	<h3>* 회원 등급 변경 결과 *</h3>
	<%
		String id = request.getParameter("id").trim();
		String mlevel = request.getParameter("mlevel").trim();

		int res = dao.level(id, mlevel);

		if (res == 0) {
			out.print("<p>회원등급 변경 실패</p>");
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("  alert('변경 되었습니다');");
			out.print("  window.location='memLevel.jsp';");
			out.print("</script>");
		} // if end
	%>
</body>
</html>