<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	* 글 상세보기 *<br/>
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
dto=dao.read(bbsno);
if(dto==null){ 
  out.print("관련자료없음");
}
else {
%>
    <table border=1>
    <tr>
      <td>제목</td>
      <td><%=dto.getSubject()%></td>
    </tr>
    <tr>
      <td>내용</td>
      <td>
<% 
     String content = Utility.convertChar(dto.getContent());
      out.println(content);
%>
      </td>
    </tr>
    <tr>
      <td>조회수</td>
      <td><%=dto.getReadcnt()%></td>
    </tr>
    <tr>
      <td>작성자</td>
      <td><%=dto.getWname()%></td>
    </tr>
    <tr>
      <td>작성일</td>
      <td><%=dto.getRegdt()%></td>
    </tr>
    <tr>
      <td>IP</td>
      <td><%=dto.getIp()%></td>
    </tr>
    </table>
    </br>
    <form method="post">
      <input type="hidden" name="bbsno" value="<%=bbsno %>">
      <input type="button" value="목록" onclick="move(this.form,'bbsList.jsp')">
      <input type="button" value="답변" onclick="move(this.form,'bbsReply.jsp')">
      <input type="button" value="수정" onclick="move(this.form,'bbsUpdate.jsp')">
      <input type="button" value="삭제" onclick="move(this.form,'bbsDel.jsp')">
    </form> 
    
    <script>
    function move(f,file) {
      //alert(f);
      //alert(file);
      f.action = file;
      f.submit();
    }
    </script>   
<%  
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>