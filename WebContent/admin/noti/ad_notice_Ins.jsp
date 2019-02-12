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
		String subject = request.getParameter("subject").trim();
		String content = request.getParameter("content").trim();
	
		dto.setSubject(subject);
		dto.setContent(content);
			
		int res = dao.insert(dto);

		if (res == 0) {
			out.print("<p>글쓰기 실패</p>");
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("  alert('글쓰기 성공');");
			out.print("  window.location='ad_notice_List.jsp';");
			out.print("</script>");
		} // if end
	%>


</body>
</html>