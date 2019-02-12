<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>

<!--  본문시작 -->
<h1>* 삭 제 *</h1>
<p>
	<a href="bbslist.do">[글목록]</a>
</p>
<form method="post" action="bbsdelproc.do">
	<input type="hidden" name="num" value="${num }">
	<input type="hidden" name="pageNum" value="${pageNum }">
	<table style="margin: 0 auto; text-align: center">
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="10"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="확인">
			</td>
		</tr>
	</table>
</form>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>