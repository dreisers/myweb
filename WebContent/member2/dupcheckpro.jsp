<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script>
	function apply(check) {
	
	<c:choose>
		<c:when test="${action=='아이디' }">
		opener.document.regForm.id.value = check;
		</c:when>
		<c:when test="${action=='이메일'}">
		opener.document.regForm.email.value = check;
		</c:when>
		</c:choose>
		window.close();
	}//apply end
</script>

<div style="text-align: center;">
	<h3>${action }중복확인 결과</h3>


	<c:choose>
		<c:when test="${cnt==0 }">
			<script>
				apply("${check}");
			</script>
		</c:when>
		<c:otherwise>
			<p style='color: red'>이미 가입된 ${action }입니다.</p>
			<hr>
			<a href="javascript:history.back()">[다시검색]</a>
			&nbsp;&nbsp;
			<a href="javascript:window.close()">[창닫기]</a>
		</c:otherwise>
	</c:choose>
</div>



</body>
</html>