<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<a href="noticeList.jsp">[글목록]</a>
<form name="noticefrm" method="post" action="noticeIns.jsp">
<table style="margin:0 auto; text-align:center">
<tr>
    <th class="form">제목</th>
    <td><input type="text" name="subject" size="25"></td>
</tr> 
<tr>
    <th class="form">내용</th>
    <td>
      <textarea rows="5" cols="30" name="content"></textarea>
    </td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="쓰기">
      <input type="reset" value="취소">
    </td>
</tr> 
</table>
</form>
	
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>