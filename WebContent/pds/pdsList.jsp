<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<style>
table {
 text-align: center;
 border: 1px solid;
 margin: auto;
 
}

th, td{
 border: 1px solid;
 text-align: center;
 
}

</style>
	<h3> * 포토갤러리 * </h3>
	글 갯수 : 
	<strong><%=dao.count(col, word) + "개" %></strong>
		<p><a href="pdsForm.jsp">[사진올리기]</a></p>
		
		<table>
		<tr>
		<th>글번호</th>
		<th>제목</th>
		<th>사진</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
		</tr>
<%
		int recordPerPage = 10;
		
		int totalRecord = dao.count(col, word);
		
		ArrayList<PdsDTO> list = dao.list(col, word, nowPage, recordPerPage);
		if (list == null) {
			out.println("<tr><td colspan='8'>자료없음</td></tr>");
		} else {
			String today = Utility.getDate();
			for (int idx = 0; idx < list.size(); idx++) {
				dto = list.get(idx);

%>
	<tr>
	<td><%=dto.getPdsno() %></td>
	<td><a href="pdsRead.jsp?pdsno=<%=dto.getPdsno() %>"><%=dto.getSubject() %></a></td>
	<td><img src="../upload/<%=dto.getFilename() %>" width="100" height="100" ></td>
	<td><%=dto.getWname() %></td>
	<td><%=dto.getReadcnt() %></td>
	<td><%=dto.getRegdate().substring(0, 10) %></td>
	</tr>
<%
	} //for end
%>
<tr>
	<td colspan="7">
		<%
			String paging = new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word, "pdsList.jsp");
				out.println(paging);
		%>
	</td>
</tr>
<!-- 검색시작 -->
<tr>
	<td colspan="7" style="text-align:center; height:20px;">
	<form method="get" action="pdsList.jsp" onsubmit="return searchCheck(this)">
	  <select name="col" class="checkbox1">
		<option value="wname">작성자
		<option value="subject">제목
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
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>