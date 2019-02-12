<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ad_notice_menu.jsp</title>
<base target="down">
</head>
<body>
<form name="notifrm" method="post">
<table>
<tr>
  <td><strong>공/지/사/항/관/리</strong></td>
  </tr>
  <tr>
  <td>
    <input type="button" value="공지관리" onclick="move('ad_notice_List.jsp')">
  </td>
</tr>
</table>
</form>

<script>
function move(file){
	document.notifrm.action=file;
	document.notifrm.submit();
}
</script>
</body>
</html>
