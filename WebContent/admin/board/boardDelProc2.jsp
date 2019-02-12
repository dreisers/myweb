<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../pds/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>boardDelProc.jsp</title>
</head>
<body>
	<%
		int pdsno = Integer.parseInt(request.getParameter("pdsno"));
		String saveDir = application.getRealPath("/upload"); 
		
		int res = dao.delete(pdsno, saveDir); 

		if (res == 0) {
			out.print("<p>회원 삭제 실패</p>");
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("  alert('삭제 되었습니다');");
			out.print("  window.location='photo.jsp';");
			out.print("</script>");
		} // if end
	%>


</body>
</html>