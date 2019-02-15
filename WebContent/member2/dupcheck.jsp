<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  본문시작 -->

	<div style="text-align: center;">
		<h3>${action } 중복확인</h3>
		<form method="post" action="" onsubmit="return blankCheck(this)">
			${action } : <input type="text" name="check" maxlength="50" autofocus="autofocus">
					 	 <input type="submit" value="중복확인">
		</form>
	</div>

<script>

	function blankCheck(f) {
		var check = f.check.value.trim();

		<c:choose>
		<c:when test="${action=='아이디'}">
		var id = /^[A-Za-z0-9]{5,10}$/;
		if (id.test(check) == false) {
			alert("아이디는 5~10자의 영문과 숫자로만 입력해주세요");
			f.check.focus();
			return false;
		}// if end
		f.action = "idcheckPro.do"; //dupcheckpro.java
		return true;
		</c:when>
		
		<c:when test="${action=='이메일'}">
		var mail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (mail.test(check) == false) {
			alert("이메일 형식이 맞지 않습니다");
			f.check.focus();
			return false;
		}// if end
		f.action = "emailcheckPro.do"; //dupcheckpro.java
		return true;
		</c:when>
		</c:choose>
	}//idCheck end
</script>

