<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->

<h3>* 로그인 결과 *</h3>
<c:choose> 
	<c:when test="${res==1 }">
		<c:set var="s_id" value="${sessionScope.s_id }" scope="session" />
		<meta http-equiv="Refresh" content="0;url=/myweb/member2/loginForm.do">
	</c:when>
	<c:otherwise>
		아이디 또는 비밀번호가 틀렸습니다.<br>
		<a href='javascript:history.back();'>[다시시도]</a>
	</c:otherwise>
</c:choose>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>