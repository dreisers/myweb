<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>

<!--  본문시작 -->
<form method="post" action="${page }.do">
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