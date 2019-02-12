<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bbsDel.jsp</title>
</head>
<body>
  <h1>* 삭 제 *</h1>
  <p><a href="pdsList.jsp">[글목록]</a></p>
	<form method = "get" action="pdsDelProc.jsp" onsubmit="return pwCheck(this)">  
	      <input type="hidden" name="pdsno" value="<%=request.getParameter("pdsno") %>">
<table style="margin:0 auto; text-align:center">
<tr>
    <th>비밀번호</th>
    <td><input type="password" name="passwd" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="확인">
      <input type="reset"  value="취소">  
    </td>
</tr> 
</table>
</form>

	
</body>
</html>
<%@ include file='../footer.jsp'%>