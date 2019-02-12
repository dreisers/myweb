<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../bbs/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>mem/freeboardList.jsp</title>
<style>
table {
	width: 80%;
	border: 1px solid #ffffff;
	border-collapse: collapse;
	margin: auto;
}

td, th {
	border: 1px solid #444444;
}
</style>
</head>
<body>
	<h3>* 자유게시판 관리 *</h3>
	글 갯수 :
	<strong><%=dao.count(col, word) + "개"%></strong>
	<hr>
	<table>
		<tr style="text-align: center; background: bisque;">
			<th>글번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>글삭제</th>

		</tr>
		<%
			int recordPerPage = 15;

			int totalRecord = dao.count(col, word);
			
			ArrayList<BbsDTO> list = dao.list(col, word, nowPage, recordPerPage);
			if (list == null) {
				out.println("<tr><td colspan='8'>자료없음</td></tr>");
			} else {
				String today = Utility.getDate();
				for (int idx = 0; idx < list.size(); idx++) {
					dto = list.get(idx);
		%>
		<tr style="text-align: center; background: cornsilk;">
			<td><%=dto.getBbsno()%></td>
			<td><%=dto.getWname()%></td>
			<td><%=dto.getSubject()%></td>
			<td><%=dto.getRegdt()%></td>
			<td><%=dto.getReadcnt()%></td>
			<td>
				<form action="boardDelProc.jsp">
				<input type="hidden" name="bbsno" value="<%=dto.getBbsno() %>">
					<input type="button" name="delete" value="삭제"	onclick="mdelete(this.form)">
				</form>
			</td>
		</tr>



		<%
			} //for end
		%>
		<tr>
			<td colspan="6">
				<%
					String paging = new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word, "freeboard.jsp");
						out.println(paging);
				%>
			</td>
		</tr>
<!-- 검색시작 -->
		<tr>
			<td colspan="6" style="text-align:center; height:20px;">
			<form method="get" action="freeboard.jsp" onsubmit="return searchCheck(this)">
			  <select name="col" class="checkbox1">
				<option value="wname">작성자
				<option value="subject">제목
				<option value="content">내용
				<option value="subject_content">제목+내용
		   	  </select>
		   	  <input type="text" name="word" class="textbox1">
		   	  <input type="submit" value="검색" class="button2"> 
			</form>
		</td>
	</tr>
	<!-- 검색끄읏 -->
		<%
			} //if end
		%>
	</table>

	<script>
		function mdelete(f) {
			var message = "삭제 하시겠습니까?"
			if (confirm(message)) {
				f.submit();
			}//if end
		}//mdelete end
	</script>
</body>
</html>


