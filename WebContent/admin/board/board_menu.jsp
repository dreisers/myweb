<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mem_menu.jsp</title>
<base target="down">
</head>
<body>
<form name="boardfrm" method="post">
<table>
<tr>
  <td><strong>게/시/판/관/리</strong></td>
  </tr>
  <tr>
  <td>
    <input type="button" value="게시판목록" onclick="move('boardList.jsp')">
  </td>
</tr>
</table>
</form>

<script>
function move(file){
	document.boardfrm.action=file;
	document.boardfrm.submit();
}
</script>
</body>
</html>
