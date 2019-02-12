<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	 <h1>* 수 정 결 과 *</h1>
  <p><a href="noticeList.jsp">[글목록]</a></p>
<%
// 1) 사용자 입력 요청 정보 변수에 담기
int noticeno=Integer.parseInt(request.getParameter("noticeno"));
String subject=request.getParameter("subject").trim();
String content=request.getParameter("content").trim();

// 2) 1)의 내용을 dto객체에 담기 
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
  out.print("  window.location='noticeList.jsp?col=" + col + "&word=" + word + "&nowPage=" + nowPage + "';");
  out.print("</script>");
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>