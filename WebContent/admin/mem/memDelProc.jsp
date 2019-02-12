<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>memDelProc.jsp</title>
</head>
<body>
	<%
		String id = request.getParameter("id").trim();

		int res = dao.delete(id); // 새로만들기

		if (res == 0) {
			out.print("<p>회원 삭제 실패</p>");
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("  alert('삭제 되었습니다');");
			out.print("  window.location='memLevel.jsp';");
			out.print("</script>");
		} // if end
	%>


</body>
</html>