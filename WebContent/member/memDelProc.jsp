<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<%	
	String passwd = request.getParameter("passwd").trim();
	
	
	int res = dao.delete(s_id, passwd);
	if(res==0) {
		out.println("<p>회원탈퇴 실패.</p>");
		out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	  }else {
		out.print("<script>");
		out.print("  alert('회원탈퇴 성공.');");
		out.print("  window.location='loginForm.jsp'");
		out.print("</script>");
		
		
		session.removeAttribute("s_id");
		session.removeAttribute("s_pw");
	  }
	
	
	
	%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>