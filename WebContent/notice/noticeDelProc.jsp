<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<h3> * 글 삭제 결과 *</h3>
<%
// 1) 사용자 입력 요청 정보 변수에 담기
int noticeno=Integer.parseInt(request.getParameter("noticeno"));


// 2) 1)의 내용을 dto객체에 담기 
dto.setNoticeno(noticeno);

int res=dao.delete(dto); 
if(res==0){
  out.print("글삭제 실패<br/>");
  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
}
else {
  out.print("<script>");
  out.print("  alert('삭제 되었습니다');");
  out.print("  window.location='noticeList.jsp?nowPage=" + nowPage + "';");
  out.print("</script>");
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>