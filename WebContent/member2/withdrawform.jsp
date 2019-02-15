<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<h1>*회 원 탈 퇴 *</h1>

<c:choose> <%-- 다중 if 문  --%>
<c:when test="${res==0 }"> <%-- c:if  --%>
  회원탈퇴 실패<br>
  <a href='javascript:history.back();'>[다시시도]</a>
</c:when>
<c:otherwise> <%-- else --%>
	<c:remove var="s_id" scope="session"/>  <%-- 세션정보 삭제(id, passwd) --%>
	<c:remove var="s_passwd" scope="session"/>
	
  <script>
  alert('정상적으로 탈퇴 되었습니다');
  window.location="loginFrom.do";
  </script>

</c:otherwise> 
</c:choose>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>