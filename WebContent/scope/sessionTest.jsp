<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>sessionTest.jsp</title>
	</head>
	
	<body>
		<h3>세션 session</h3>
		<%
		/* session 내부객체
			- HttpSession session
			- 요청한 사용자에게 개별적으로 접근
			- 선언된 세션변수는 전역적 성격으로 유지된다
			- 일정 시간동안 이베트가 발생되지 않으면 자동 삭제
		*/
		out.println("현재 세션 유지 시간 : ");
		out.println(session.getMaxInactiveInterval());
		out.println("초 (30분)");
		out.println("<hr>");
		
		//세션 유지 시간 변경
		//1)
		session.setMaxInactiveInterval(60*10);
		out.println("변경된 세션 유지 시간 : ");
		out.println(session.getMaxInactiveInterval());
		out.println("초 (10분)");
		out.println("<hr>");

		//2) /WEB-INF/web.xml 배치관리자
/* 			세션시간설정, 환경설정 ~
				web.xml이 수정되면 반드시 서버를 재시작!
			<!-- 세션 유지 시간 설정 -->
			<session-config>
				<session-timeout>600</session-timeout>
			</session-config>
 */
 		//세션변수	→ myweb 프로젝트의 모든 페이지에서 공유
 		//				→ 별도의 자료형이 없다
 		
 		//세션변수 선언
 		//session.setAttribute("변수명", 값);
 		session.setAttribute("s_id", "soldesk");
 		session.setAttribute("s_pw", "12341234");
 		
 		//세션변수 값 가져오기
 		Object obj=session.getAttribute("s_id");
 		String s_id=(String)obj;
 		String s_pw=(String)session.getAttribute("s_pw");
 		
 		out.println("세션변수 s_id : "+s_id+"<br>");
 		out.println("세션변수 s_pw : "+s_pw+"<br>");
 		
 		//세션변수 강제 삭제(로그아웃)
 		session.removeAttribute("s_id");
 		session.removeAttribute("s_pw");
 		
 		out.println("세션변수 삭제 후 <br>");
 		out.println("세션변수 s_id"+session.getAttribute("s_id"));
 		out.println("<br>");
 		out.println("세션변수 s_pw"+session.getAttribute("s_pw"));
 		out.println("<hr>");
 		
 		//세션 영역에 있는 모든 값 전부 강제 삭제
 		//session.invalidate();
 		
 		//세션 객체에서 발급해 주는 아이디
 		out.println("세션 임시 아이디 : ");
 		out.println(session.getId());
 		out.println("<hr>");
 		//-------------------------------------------------------------
 		
 		/* application 내부객체
 			- 사용자 모ㅜ가 공유하는 전역적 성격의 객체
 			ServletContext application
 		*/
 		//	/member 폴더의 실제 물리적인 경로 파악
 		//D:\java1113\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\myweb\member
 		//	실제경로 D:\java1113\workspace\myweb\WebContent\member
 		//	웹경로	 http://172.16.10.8:9090/myweb/member
 		out.println(application.getRealPath("/member"));	//강추
 		out.println("<hr>");
 		
 		//request 객체의 getreaalpath

 		out.println(request.getRealPath("/member"));
 		out.println("<hr>");
 		
 		//application 변수
 		application.setAttribute("uname", "손흥민");
 		out.println(application.getAttribute("uname"));
 		out.println("<hr>");
 		//--------------------------------------------------------------
 		//request 내부객체
 		// - 요청한 사용자에게 응답할 때
 		// - 페이지 이동
 		//    request.sendRedirect("파일명");
 		
 		// - 요청한 사용자에게 응답할 메세지 전송
 		//    PrintWriter prn=response.getWriter();
		
		%>
		
		
	</body>
</html>