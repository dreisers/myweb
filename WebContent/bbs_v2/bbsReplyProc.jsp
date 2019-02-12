<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp'%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<h3>* 답변 결과 *</h3>
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
String wname  =request.getParameter("wname").trim();
String subject=request.getParameter("subject").trim();
String content=request.getParameter("content").trim();
String passwd =request.getParameter("passwd").trim();
String ip     =request.getRemoteAddr(); // 사용자PC IP

dto.setBbsno(bbsno);
dto.setWname(wname);
dto.setSubject(subject);
dto.setContent(content);
dto.setPasswd(passwd);
dto.setIp(ip);

int res=dao.reply(dto); 
if(res==0){
  out.println("<p>답변 실패<p>");
  out.print("<p><a href='javascript:history.back();'>[다시시도]</a><p>");
}
else {
  out.print("<script>");
  out.print("  alert('답변글이 추가되었습니다');");
  out.print("  location.href='bbsList.jsp?col=" + col + "&word=" + word + "';");
  out.print("</script>");
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
