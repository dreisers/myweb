<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 memberForm.jsp-->
* 회/원/가/입 *<br><br>
<!--  본문시작 -->
<%
// 1) 사용자 입력 요청 정보 변수에 담기
String id=request.getParameter("id").trim();
String passwd=request.getParameter("passwd").trim();
String mname=request.getParameter("mname").trim();
String tel =request.getParameter("tel").trim();
String email=request.getParameter("email").trim();
String zipcode=request.getParameter("zipcode").trim();
String address1=request.getParameter("address1").trim();
String address2=request.getParameter("address2").trim();
String job=request.getParameter("job");

// 2) 1)의 내용을 dto객체에 담기 
dto.setId(id);
dto.setPasswd(passwd);
dto.setMname(mname);
dto.setTel(tel);
dto.setEmail(email);
dto.setZipcode(zipcode);
dto.setAddress1(address1);
dto.setAddress2(address2);
dto.setJob(job);

int res=dao.insert(dto); 

if(res==0){
	out.print(res);
  out.print("회원가입 실패<br/>");
  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
}
else {
  out.print("<script>");
  out.print("  alert('회원가입 성공');");
  out.print("  window.location='loginForm.jsp';");
  out.print("</script>");
}
%>
<!--  본문끝 -->
