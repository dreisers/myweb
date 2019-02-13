<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!--  본문시작 -->
<h3> * 글 수정 *</h3>

		<form method="post" action="./updateform.do">
			<input type="hidden" name="num" value="${num }">
			<input type="hidden" name="pageNum" value="${pageNum }">
			<table style="margin: 0 auto; text-align: center">
				<tr>
					<th>이름</th>
					<td><input type="text" name="writer" size="25" value="${article.writer }"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="subject" size="25" value="${article.subject }"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" size="25" value="${article.email }"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="5" cols="30" name="content">${article.content }</textarea></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="passwd" size="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="완료">
						<input type="reset" value="취소"></td>
				</tr>
			</table>
		</form>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>
