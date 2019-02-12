<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bbsUpdateproc.jsp</title>
  <link rel="stylesheet" type="text/css" href="../css/css1.css?after">
  <script src="../js/myscript.js"></script>
</head>
<body>
  <h1>* 수 정 결 과 *</h1>
  <p><a href="bbsList.jsp">[글목록]</a></p>
<%
// 1) 사용자 입력 요청 정보 변수에 담기
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
String wname  =request.getParameter("wname").trim();
String subject=request.getParameter("subject").trim();
String content=request.getParameter("content").trim();
String passwd =request.getParameter("passwd").trim();
String ip     =request.getRemoteAddr();

// 2) 1)의 내용을 dto객체에 담기 
dto.setBbsno(bbsno);
dto.setWname(wname);
dto.setSubject(subject);
dto.setContent(content);
dto.setPasswd(passwd);
dto.setIp(ip);

int res=dao.updateproc(dto); 
if(res==0){
  out.print("글수정 실패<br/>");
  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
}
else {
  out.print("<script>");
  out.print("  alert('글수정 성공');");
  out.print("  window.location='bbsList.jsp';");
  out.print("</script>");
}
%>


<%@ include file='../footer.jsp'%>