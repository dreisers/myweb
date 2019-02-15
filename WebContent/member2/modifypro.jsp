<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='../header.jsp' %>
<!-- 본문 시작 memberForm.jsp-->
* 정/보/수/정 *<br>
<br>
<!--  본문시작 -->
<c:choose>
	<c:when test="${res==0 }">
		정보변경 실패<br />
		<a href='javascript:history.back();'>[다시시도]</a>
	</c:when>
	<c:otherwise>
		<script>
			alert('정보변경 성공');
			window.location = 'loginForm.do';
		</script>
	</c:otherwise>
</c:choose>
<!--  본문끝 -->
