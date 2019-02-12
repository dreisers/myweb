<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	  <h1>* 삭 제 *</h1>
  <p><a href="noticeList.jsp">[글목록]</a></p>
	<form method = "get" action="noticeDelProc.jsp">  
	      <input type="hidden" name="noticeno" value="<%=request.getParameter("noticeno") %>">
	      <input type="hidden" name="nowPage" value="<%=nowPage%>">
<table style="margin:0 auto; text-align:center">
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="확인">
    </td>
</tr> 
</table>
</form>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>