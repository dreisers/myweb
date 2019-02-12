<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<h3> * 글 삭제 결과 *</h3>



<c:choose> <%-- 다중 if 문  --%>
<c:when test="${res==0 }"> <%-- c:if  --%>
  글삭제 실패<br>
  <a href='javascript:history.back();'>[다시시도]</a>
</c:when>
<c:otherwise> <%-- else --%>
  <script>
  alert('삭제 되었습니다');
  window.location="bbslist.do?=" + ${pageNum };
  </script>

</c:otherwise> 
</c:choose>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
