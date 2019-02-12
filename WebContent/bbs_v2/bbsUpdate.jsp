<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
  <h1>* 수 정 *</h1>
  <p><a href="bbsList.jsp">[글목록]</a></p>
	<form method = "post" action="bbsUpdateForm.jsp" onsubmit="return upCheck(this)">  
	      <input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
	      <input type="hidden" name="col" value="<%=col%>">
		  <input type="hidden" name="word" value="<%=word%>">
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

	

<%@ include file='../footer.jsp'%>