<%@page import="javax.jws.soap.SOAPBinding.Style"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->

<a href="bbsForm.jsp">[글쓰기]</a>

<table  class="listtable" style="margin:0 auto; text-align:center; font-size:20px; ">
<tr style="border:1px solid; background-color: rgb(138, 217, 248);">
  <th style="text-align:center">글번호</th>
  <th style="text-align:center">작성자</th>
  <th style="text-align:center">제목</th>
  <th style="text-align:center">작성일</th>
  <th style="text-align:center">조회수</th>
</tr>
<%
ArrayList<BbsDTO> list=dao.list(); //글 목록
if(list==null){
  out.print("<tr><td colspan=4>관련 자료 없음!!</td></tr>");
}
else {
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
		out.println("<img src='../images/k2.png' width=20 >");
	}
%>
<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>"><%=dto.getSubject() %></a>
<% 
		String regdt = dto.getRegdt().substring(0, 10);
		if(regdt.equals(today)){
			out.println("<img src='../images/k4.png' width=35 >");
		}
		//조회수가 10이상이면 글씨 진하게, 글씨색상 파란색
      if(dto.getReadcnt()>=10){
    	  out.println("<img src='../images/k1.png' width=30>");
      }
%> 
      </td>
      <td><%=dto.getRegdt().substring(0,10) %></td>
      <td><%=dto.getReadcnt() %></td>
    </tr>    
<%    
  }
}
%>
</table>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>