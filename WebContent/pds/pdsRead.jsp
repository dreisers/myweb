<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<style>
th {
	font-size: 20px bold;
	text-align: center;
	
}


</style>

<%
int pdsno=Integer.parseInt(request.getParameter("pdsno"));
dto=dao.read(pdsno);
if(dto==null){ 
  out.print("관련자료없음");
}
else {
%>
    <table class="readtable">
    <th colspan="8"><%=dto.getSubject()%> </th>
    <tr>
      <td class="tg-td1">조회수</td>
      <td class="tg-td2"><%=dto.getReadcnt()%></td>
      <td class="tg-td1">작성자</td>
      <td class="tg-td2"><%=dto.getWname()%></td>
    </tr>
    <tr>
      <td colspan="8"><img src="../upload/<%=dto.getFilename() %>" width="400" ></td>
    </tr>
    <tr>
    <td class="tg-td1" colspan="2">작성일</td>
      <td class="tg-td2" colspan="2"><%=dto.getRegdate()%></td>
      </tr>
     <tr>
     <td class="tg-td1" colspan="2">파일명 : <%=dto.getFilename()%></td>
     <td class="tg-td2" colspan="2">파일크기 : <%=dto.getFilesize()%></td>
     </tr>
    </table>
        <form>
 	  <input type="hidden" name="pdsno" value=<%=pdsno %>>       
      <input type="button" value="목록" onclick="move(this.form,'pdsList.jsp')">
      <input type="button" value="수정" onclick="move(this.form,'pdsUpdate.jsp')">
      <input type="button" value="삭제" onclick="move(this.form,'pdsDel.jsp')">
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