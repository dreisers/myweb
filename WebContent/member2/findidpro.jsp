<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->

	<c:choose>
		<c:when test="${id==null }">
			<p>아이디 찾기 실패</p>
			<a href='javascript:history.back();'>[다시시도]</a>
		</c:when>
		<c:otherwise>
			<script>
				alert("${mname}" + '님의 아이디는 ' + "${id}" + ' 입니다.')
				window.location = 'loginForm.do'
			</script>
		</c:otherwise>
	</c:choose>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>