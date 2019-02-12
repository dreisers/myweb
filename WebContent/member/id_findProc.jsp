<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<%
	
		String mname = request.getParameter("mname").trim();
		String email = request.getParameter("email").trim();
		
		dto.setMname(mname);
		dto.setEmail(email); 
	
		String id = dao.find_id(mname, email);

		if (id == null) {
			out.print("<p>아이디 찾기 실패</p>"); //id null...
			out.print("<a href='javascript:history.back();'>[다시시도]</a>");
		} else {
			out.print("<script>");
			out.print("alert('" + id + "');");
			out.print("  window.location='loginForm.jsp';");
			out.print("</script>");
		} // if end
	%>

	
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>