<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>emailCheckForm.jsp</title>
</head>
<body>
	<div style="text-align: center;">
		<h3> 이메일 중복확인</h3>
		<form method="post" action="emailCheckProc.jsp" onsubmit="return emailCheck(this)">
			이메일 : <input type="text" name="email" maxlength="30" autofocus="autofocus"> 
  					 <input type="submit" vlaue="중복확인">
		</form>
	</div>
	
	<script>
	function emailCheck(f) {
		var email = f.email.value;
		var m = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		email = email.trim();
		if(m.test(email)==false){
			alert("이메일 형식이 맞지 않습니다");
			f.email.focus();
			return false;
		}// if end
		return true;
	}//emailCheck end
	</script>
</body>
</html>