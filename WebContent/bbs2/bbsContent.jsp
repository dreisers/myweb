<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>

	<!-- 본문 시작 -->
	
	<p><strong>글 내용보기</strong></p>
	<table>
		<tr>
			<td bgcolor="${value_c }">글번호</td>
			<td>${article.num }</td>
			<td bgcolor="${value_c }">조회수</td>
			<td>${article.readcount }</td>
		</tr>
		<tr>
			<td bgcolor="${value_c }">작성자</td>	
			<td>${article.writer }</td>	
			<td bgcolor="${value_c }">작성일</td>	
			<td>${article.reg_date }</td>	
		</tr>
		<tr>
			<td bgcolor="${value_c }">글제목</td>	
			<td>${article.subject }</td>	
		</tr>
		<tr>
			<td bgcolor="${value_c }">글내용</td>	
			<td colspan=3>
			<%  //치환 변수 선언
				pageContext.setAttribute("cn", "\n");
				pageContext.setAttribute("br", "<br/>");
			%>
				<%-- ${article.content} --%>
				<!--  \n값이 <br/>값으로 바꿔서 출력 -->
				${fn:replace(article.content, cn, '<br/>') }
			</td>	
		</tr>
		<tr>
			<td colspan=4 bgcolor="${value_c }">
				<input type="button" value="글수정" onclick="location.href='./pwcheck.do?num=${article.num }&pageNum=${pageNum }&page=bbsupdate'">
				<input type="button" value="글삭제" onclick="location.href='./pwcheck.do?num=${article.num }&pageNum=${pageNum }&page=bbsdel'">
				<input type="button" value="답변" onclick="location.href='./bbsform.do?num=${article.num }&ref=${article.ref }&re_step=${article.re_step }&re_level=${article.re_level }'">
				<input type="button" value="목록" onclick="location.href='./bbslist.do?pageNum=${pageNum }'">
			</td>
			 
		</tr>
	</table>
<!-- 본문 끝 -->			
<%@ include file="../footer.jsp" %>