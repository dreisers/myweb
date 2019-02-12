<%@page import="javax.security.auth.Subject"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp'%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<h3> * 글 수정 *</h3>
<%
// 1) 사용자 입력 요청 정보 변수에 담기
String passwd = request.getParameter("passwd").trim();
int bbsno=Integer.parseInt(request.getParameter("bbsno"));


// 2) 1)의 내용을 dto객체에 담기 
dto.setPasswd(passwd);
dto.setBbsno(bbsno);

dto=dao.updateform(dto); 
if(dto==null){
  out.println("<script>");
  out.println("  alert('비밀번호가 일치하지 않습니다.');");
  out.println("  history.back();");
  out.println("</script>");
}else{
%>
	<form name="bbsfrm" method="get" action="bbsUpdateProc.jsp" onsubmit="return upCheck(this)">
	<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
	<input type="hidden" name="col" value="<%=col%>">
	<input type="hidden" name="word" value="<%=word%>">
	<table style="margin:0 auto; text-align:center">
	<tr>
	    <th>작성자</th>
	    <td><input type="text" name="wname" size="25" value="<%=dto.getWname() %>"></td>
	</tr> 
	<tr>
	    <th>제목</th>
	    <td><input type="text" name="subject" size="25" value="<%=dto.getSubject() %>"></td>
	</tr> 
	<tr>
	    <th>내용</th>
	    <td>
	      <textarea rows="5" cols="30" name="content"><%=dto.getContent() %></textarea>
	    </td>
	</tr> 
	<tr>
	    <th>비밀번호</th>
	    <td><input type="password" name="passwd" size="10" value=<%=dto.getPasswd() %>></td>
	</tr> 
	<tr>
	    <td colspan="2" align="center">
	      <input type="submit" value="완료">
	      <input type="reset" value="취소">
	    </td>
	</tr> 
	</table>
	</form>
<%

}

%>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
