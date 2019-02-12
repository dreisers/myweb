<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<h3> * 사진삭제 결과 페이지 * </h3>
<%	
int pdsno=Integer.parseInt(request.getParameter("pdsno"));
String passwd = request.getParameter("passwd").trim();
String saveDir = application.getRealPath("/upload");

dto.setPdsno(pdsno);
dto.setPasswd(passwd);

int res = dao.delete(pdsno, passwd, saveDir);
if(res==0) {
	out.println("<p>비밀번호가 일치하지 않습니다.</p>");
	out.print("<a href='javascript:history.back();'>[다시시도]</a>");
  }else {
	out.print("<script>");
	out.print("  alert('삭제 되었습니다');");
	out.print("  window.location='pdsList.jsp'");
	out.print("</script>");
	}

%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>