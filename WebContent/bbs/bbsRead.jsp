<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp'%>
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
    <table class="readtable">
    <th colspan="2" class="tg">게시판</th>
    <tr>
      <td class="tg-td1">제 목</td>
      <td class="tg-td2"><%=dto.getSubject()%></td>
    </tr>
    <tr>
      <td class="tg-td1">내 용</td>
      <td class="tg-td2">
<% 
     String content = Utility.convertChar(dto.getContent());
      out.println(content);
%>
      </td>
    </tr>
    <tr>
      <td class="tg-td1">조회수</td>
      <td class="tg-td2"><%=dto.getReadcnt()%></td>
    </tr>
    <tr>
      <td class="tg-td1">작성자</td>
      <td class="tg-td2"><%=dto.getWname()%></td>
    </tr>
    <tr>
      <td class="tg-td1">작성일</td>
      <td class="tg-td2"><%=dto.getRegdt()%></td>
    </tr>
    <tr>
      <td class="tg-td1">IP</td>
      <td class="tg-td2"><%=dto.getIp()%></td>
    </tr>
    </table>
    </br>
    <form method="get">
      <input type="hidden" name="bbsno" value="<%=bbsno%>">
      <input type="hidden" name="col" value="<%=col%>">
      <input type="hidden" name="word" value="<%=word%>">
      <input type="hidden" name="nowPage" value="<%=nowPage%>">
      <input type="button" value="목록" onclick="move(this.form,'bbsList.jsp')">
      <input type="button" value="답변" onclick="move(this.form,'bbsReply.jsp')">
<%if(s_mlevel.equals("A1")) { %>     
      <input type="button" value="수정" onclick="move(this.form,'bbsUpdate.jsp')">
      <input type="button" value="삭제" onclick="move(this.form,'bbsDel.jsp')">
<%}//if end %>
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