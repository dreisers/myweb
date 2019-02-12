<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="ssi.jsp"%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<h3> * 로그인 결과 *</h3>
	
<%
// 1) 사용자 입력 요청 정보 변수에 담기
String id=request.getParameter("id").trim();
String passwd=request.getParameter("passwd").trim();

// 2) 1)의 내용을 dto객체에 담기 
dto.setId(id);
dto.setPasswd(passwd);
String mlevel=dao.loginProc(dto);

if(mlevel==null){
  out.print("<p>로그인 실패</p>");
  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
}
else {
  //out.print("<p>로그인 성공</p>");
  //out.print("회원 등급 : " + mlevel);
  //다른 페이지에서 로그인상태를 공유할 수 있도록
  session.setAttribute("s_id", id);
  session.setAttribute("s_passwd", passwd);
  session.setAttribute("s_mlevel", mlevel);
  
  //쿠키(아이디 저장) 
  	String c_id = Utility.checkNull(request.getParameter("c_id"));
  	Cookie cookie = null;
  	
  	if(c_id.equals("SAVE")){
  		//new Cookie("쿠키변수",값)
  		cookie = new Cookie("c_id",id);
  		//쿠키의 생존기간 ex) 1개월
  		cookie.setMaxAge(60*60*24*30);
  	}else{
  		cookie = new Cookie("c_id", "");
  		cookie.setMaxAge(0);
	}//if end
	
  	//요청한 사용자 PC에 쿠키값을 저장
  	response.addCookie(cookie);
  //첫페이지로 이동
  //String root = request.getContextPath();  
  String root = Utility.getRoot(); // 학원 유틸리티 소스
  response.sendRedirect(root + "/myhome.jsp");
}
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>