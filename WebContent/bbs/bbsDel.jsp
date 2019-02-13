<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	  <h1>* 삭 제 *</h1>
  <p><a href="bbslist.jsp">[글목록]</a></p>
	<form method = "get" action="bbsDelProc.jsp" onsubmit="return pwCheck(this)">  
	      <input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
	      <input type="hidden" name="nowPage" value="<%=nowPage%>">
<table style="margin:0 auto; text-align:center">
<tr>
    <th>비밀번호</th>
    <td><input type="password" name="passwd" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="확인">
    </td>
</tr> 
</table>
</form>
	
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>