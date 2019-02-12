<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bbsDel.jsp</title>
  <link rel="stylesheet" type="text/css" href="../css/css1.css?after">
</head>
<body>
  <h1>* 삭 제 *</h1>
  <p><a href="bbsList.jsp">[글목록]</a></p>
	<form method = "post" action="bbsDelProc.jsp" onsubmit="return pwCheck(this)">  
	      <input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
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

	
</body>
</html>
<%@ include file='../footer.jsp'%>