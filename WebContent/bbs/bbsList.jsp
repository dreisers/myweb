<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->

<input type="button" value="답글 보기" class="button2" onclick="window.location='bbsComment.jsp';">

<table class="listtable" style="margin:0 auto; text-align:center; font-size:20px;">
<tr style="border:1px solid; background-color:rgb(138, 217, 248);">
  <th style="text-align:center">글번호</th>
  <th style="text-align:center">작성자</th>
  <th style="text-align:center">제목</th>
  <th style="text-align:center">작성일</th>
  <th style="text-align:center">조회수</th>
</tr>
<%
//글 갯수
int totalRecord = dao.count(col, word);

//한페이지당 출력할 글의 줄수
int recordPerPage = 10;

ArrayList<BbsDTO> list=dao.list(col, word, nowPage, recordPerPage); //글 목록
if(list==null){
    out.print("<tr><td colspan=4>관련 자료 없음!!</td></tr>");
}else {

	//오늘날짜를 "2019-01-16" 문자열 작성
	String today = Utility.getDate();
    for(int idx=0; idx<list.size(); idx++){
         dto=list.get(idx);
%>
	    <tr>
	      <td><%=dto.getBbsno() %></td>
	      <td><%=dto.getWname() %></td>
	      <td>      
<%
		//답변이미지 출력
		for(int n=1; n<=dto.getIndent(); n++){
			out.println("<img src='../images/reply.gif' width=20 >");
		}
		String regdt = dto.getRegdt().substring(0, 10); //새글 이미지
		if(regdt.equals(today)){
			out.println("<img src='../images/new.gif'>");
		}
%>
       <a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject()%></a>
<% 
		
       if(dto.getReadcnt()>=10){ //조회수가 10이상이면 이미지 등록
    	  out.println("<img src='../images/hot.gif'>");
      }
%> 
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
	  String paging = new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word, "bbsList.jsp");
	  out.println(paging);
%>
	  </td>
	</tr>
		<!-- 검색시작 -->
		<tr>
			<td colspan="4" style="text-align:center; height:20px;">
			<form method="get" action="bbsList.jsp" onsubmit="return searchCheck(this)">
			  <select name="col" class="checkbox1">
				<option value="wname">작성자
				<option value="subject">제목
				<option value="content">내용
				<option value="subject_content">제목+내용
		   	  </select>
		   	  <input type="text" name="word" class="textbox1">
		   	  <input type="submit" value="검색" class="button2"> 
		   	  <input type="button" value="글쓰기" class="button2" onclick="window.location='bbsForm.jsp';">
			</form>
		</td>
	</tr>
	<!-- 검색끄읏 -->
<%
}//if end
%> 
</table>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>