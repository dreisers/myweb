<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>idCheckForm.jsp</title>
</head>
<body>
	<div style="text-align: center;">
		<h3> 아이디 중복확인</h3>
		<form method="post" action="idCheckProc.jsp" onsubmit="return blankCheck(this)">
			아이디 : <input type="text" name="id" maxlength="20" autofocus="autofocus"> 
  					 <input type="submit" value="중복확인">
		</form>
	</div>
	
	<script>
	function blankCheck(f) {
		var id = f.id.value;
		var m = /^[A-Za-z0-9]{5,10}$/;
		id = id.trim();
		if(m.test(id)==false){
			alert("아이디는 5~10자의 영문과 숫자로만 입력해주세요");
			f.id.focus();
			return false;
		}// if end
		return true;
	}//idCheck end
	</script>
</body>
</html>
