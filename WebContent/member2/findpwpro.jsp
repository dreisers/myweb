<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file='../header.jsp'%>

<!--  본문시작 -->

		<c:choose>
		<c:when test="${res!=1 }"> 
			<p>비밀번호 찾기 실패</p>
			<a href='javascript:history.back();'>[다시시도]</a>
		</c:when>
		<c:when test="${res==1 }">
			<script>
			alert("${email}" + " 으로 임시메일 발송");
			window.location = 'loginForm.do';
			</script>
		</c:when>
		</c:choose>
			
			

	
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>