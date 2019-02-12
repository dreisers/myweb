<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<h3>공 지 사 항</h3>
<table class="listtable" style="margin:0 auto; text-align:center; font-size:20px;">
<tr style="border:1px solid; background-color:rgb(138, 217, 248);">
  <th style="text-align:center">글번호</th>
  <th style="text-align:center">제목</th>
  <th style="text-align:center">작성일</th>
  <th style="text-align:center">조회수</th>
  </tr>
<%
//글갯수
int totalRecord = dao.count(col, word);

//한페이지당 출력할 글 갯수
int recordPerPage = 10;

ArrayList<NoticeDTO> list=dao.list(col, word, nowPage, recordPerPage); //글 목록
		if(list==null){
		    out.print("<tr><td colspan=4>관련 자료 없음!!</td></tr>");
		}else {
		String today = Utility.getDate();
		for(int idx=0; idx<list.size(); idx++){
		     dto=list.get(idx);
%>
    <tr>
      <td><%=dto.getNoticeno() %></td>
      <td>      
   <a href="noticeRead.jsp?noticeno=<%=dto.getNoticeno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject()%></a>
  </td>
  <td><%=dto.getRegdt().substring(0,10) %></td>
  <td><%=dto.getReadcnt() %></td>
</tr>  
<%
		}//for end
  //글갯수
  out.println("<tr>");
  out.println("	<td colspan='4'>");
  out.println("	  글갯수 : <strong>");
  out.println(totalRecord);
  out.println("	  </strong>");
  out.println("	</td>");
  out.println("</tr>");

%>
<tr>
  <td colspan="4">
<%
  String paging = new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word, "noticeList.jsp");
  out.println(paging);
%>
  </td>
</tr>
	<!-- 검색시작 -->
	<tr>
		<td colspan="4" style="text-align:center; height:20px;">
		<form method="get" action="noticeList.jsp" onsubmit="return searchCheck(this)">
		  <select name="col" class="checkbox1">
			<option value="wname">작성자
			<option value="subject">제목
			<option value="content">내용
			<option value="subject_content">제목+내용
	   	  </select>
	   	  <input type="text" name="word" class="textbox1">
	   	  <input type="submit" value="검색" class="button2"> 
	   	  <input type="button" value="글쓰기" class="button2" onclick="window.location='noticeForm.jsp';">
		</form>
	</td>
</tr>
<%}//if end %>
<!-- 검색끄읏 -->
  </table>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>