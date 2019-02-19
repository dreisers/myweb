<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!--  본문시작 -->
<h3> * 글 수정 *</h3>
	<c:choose>
	<c:when test="${article==null }">
		<script>
		alert("${article}");
		</script>
		비밀번호 틀림<br>
		<a href='javascript:history.back();'>[다시시도]</a>
		</c:when>
		<c:otherwise>
		<form method="post" action="./updateform.do">
			<input type="hidden" name="num" value="${num }">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<table style="margin: 0 auto; text-align: center">
				<tr>
					<th>이름</th>
					<td><input type="text" name="writer" size="25" required="required" value="${article.writer }"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="subject" size="25" required="required" value="${article.subject }"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" size="25" value="${article.email }"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="5" cols="30" name="content" required="required">${article.content }</textarea></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="passwd" size="10" required="required"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="완료">
						<input type="button" value="취소" onClick="location.href='./bbslist.do'">
					</td>
				</tr>
			</table>
		</form>
</c:otherwise>
</c:choose>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
