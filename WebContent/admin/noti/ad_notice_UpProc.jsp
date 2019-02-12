<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>memLevelProc.jsp</title>
</head>
<body>
	<h3>* 수정 결과 *</h3>
	<%
	int noticeno=Integer.parseInt(request.getParameter("noticeno"));
	String subject=request.getParameter("subject").trim();
	String content=request.getParameter("content").trim();

	dto.setNoticeno(noticeno);
	dto.setSubject(subject);
	dto.setContent(content);

	int res=dao.updateproc(dto); 
	if(res==0){
		
	  out.print("글수정 실패<br/>");
	  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	}
	else {
	  out.print("<script>");
	  out.print("  alert('글수정 성공');");
	  out.print("  window.location='ad_notice_List.jsp?col=" + col + "&word=" + word + "&nowPage=" + nowPage + "';");
	  out.print("</script>");
	}
	%>
</body>
</html>