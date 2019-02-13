<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<h3> * 글 수정 결과 *</h3>

<c:choose> 
<c:when test="${res==0 }"> 
  글수정 실패<br>
  <a href='javascript:history.back();'>[다시시도]</a>
</c:when>
<c:otherwise>
  <script>
  alert('수정 되었습니다');
  window.location="bbslist.do?pageNum=" + ${pageNum };
  </script>

</c:otherwise> 
</c:choose>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
