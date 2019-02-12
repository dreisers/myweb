<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<%
// 1) 사용자 입력 요청 정보 변수에 담기
String passwd = request.getParameter("passwd").trim();
int pdsno=Integer.parseInt(request.getParameter("pdsno"));


// 2) 1)의 내용을 dto객체에 담기 
dto.setPasswd(passwd);
dto.setPdsno(pdsno);

dto=dao.updateform(dto); 
if(dto==null){
  out.println("<script>");
  out.println("  alert('비밀번호가 일치하지 않습니다.');");
  out.println("  history.back();");
  out.println("</script>");
}else{
%>
	<form name="pdsfrm" method="post" enctype="multipart/form-data" action="pdsUpdateProc.jsp" onsubmit="return upCheck(this)">
	<input type="hidden" name="pdsno" value="<%=request.getParameter("pdsno") %>" >
	<table border="1">
  <tr> 
    <th colspan="2">파일 수정 (* 필수 입력사항)</th>
  </tr>
  <tr> 
    <td colspan="2" height="30"> </td>
  </tr>
  <tr> 
    <th width="97">성명*</th>
    <td width="5"><input type="text" name="wname" value="<%=dto.getWname()%>"> </td>
  </tr>
  <tr> 
    <th>* 제목</th>
    <td><textarea name="subject" rows='5' cols='30'><%=dto.getSubject() %></textarea></td>
  </tr>
  <tr> 
    <th>* 비밀번호</th>
    <td><input type="password" name="passwd" value="<%=dto.getPasswd()%>" ></td>
  </tr>
  <tr> 
    <th>* 파일명</th>
    <td><input type="file" name="filename" value="<%=dto.getFilename()%>"></td>
  </tr>
  <tr> 
     <td colspan="2" align="center">
        <input type="submit" value="전송">               
         <input type="button" value="취소" onclick="javascript:history.back();"/>     
	    </td>
	</tr> 
	</table>
	</form>
<%
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>