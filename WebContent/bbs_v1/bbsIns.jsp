<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp'%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<%
// 1) 사용자 입력 요청 정보 변수에 담기
String wname  =request.getParameter("wname").trim();
String subject=request.getParameter("subject").trim();
String content=request.getParameter("content").trim();
String passwd =request.getParameter("passwd").trim();
String ip     =request.getRemoteAddr(); // 사용자PC IP

// 2) 1)의 내용을 dto객체에 담기 
dto.setWname(wname);
dto.setSubject(subject);
dto.setContent(content);
dto.setPasswd(passwd);
dto.setIp(ip);

int res=dao.insert(dto); 
if(res==0){
  out.print("글쓰기 실패<br/>");
  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
}
else {
  out.print("<script>");
  out.print("  alert('글쓰기 성공');");
  out.print("  window.location='bbsList.jsp';");
  out.print("</script>");
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
