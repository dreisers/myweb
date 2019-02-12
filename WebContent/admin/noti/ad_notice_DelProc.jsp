<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>ad_notice_DelProc.jsp</title>
</head>
<body>
	<%
		int noticeno = Integer.parseInt(request.getParameter("noticeno"));

		dto.setNoticeno(noticeno);
		
		int res = dao.delete(dto);

		if (res == 0) {
			out.print("<p>공지 삭제 실패</p>");
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("  alert('삭제 되었습니다');");
			out.print("  window.location='ad_notice_List.jsp';");
			out.print("</script>");
		} // if end
	%>


</body>
</html>