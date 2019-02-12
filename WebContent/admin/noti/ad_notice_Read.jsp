<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noti/ad_notice_Read.jsp</title>
</head>
<body>
<%
int noticeno=Integer.parseInt(request.getParameter("noticeno"));
dto=dao.read(noticeno);
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
      <td class="tg-td1">작성일</td>
      <td class="tg-td2"><%=dto.getRegdt()%></td>
    </tr>
    </table>
    </br>
    <form method="get">
      <input type="hidden" name="noticeno" value="<%=noticeno%>">
      <input type="hidden" name="col" value="<%=col%>">
      <input type="hidden" name="word" value="<%=word%>">
      <input type="hidden" name="nowPage" value="<%=nowPage%>">
      <input type="button" value="목록" onclick="move(this.form,'ad_notice_List.jsp')">
<%if(s_mlevel.equals("A1")) { %>     
      <input type="button" value="수정" onclick="move(this.form,'ad_notice_Update.jsp')">
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
</body>
</html>


