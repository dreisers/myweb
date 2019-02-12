<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="net.utility.*" %>

<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%@ include file="../header.jsp" %>
<!-- 본문 시작 mailForm.jsp --> 
<h3>* 문의 메일 결과 *</h3>
<%
	//1) 메일 서버(POP3/SMTP서버) 지정하기
	String mailServer = "mw-002.cafe24.com";
	Properties props = new Properties();
	props.put("mail.smtp.host", mailServer);
	props.put("mail.smtp.auth", "true");
	
	//2) 메일서버에서 인증받은 나의 계정/비번
	Authenticator myAuth = new MyAuthenticator();
	
	//3) 1)과 2)를 유효한지 검증
    Session sess = Session.getInstance(props, myAuth);
	//out.print("메일 서버 인증 성공");
	
	try{
		//4) 메일보내기
		//	 받는사람, 보내는사람, 참조, 숨은참조
		//	 제목, 내용, 보낸날짜
		request.setCharacterEncoding("UTF-8");
		String to = request.getParameter("to").trim();
		String from = request.getParameter("from").trim();
		String subject = request.getParameter("subject").trim();
		String msgText = request.getParameter("msgText").trim();
		
		//엔터 및 특수문자 변경
		msgText = Utility.convertChar(msgText);
		
		//이미지 보여주기
		msgText += "<p>";
		msgText += "<img src='http://172.16.10.22:9090/myweb/images/1.gif'>";
		msgText += "</p>";
			
		//테이블 작성
		msgText += "<table border='1'>";
		msgText += "<tr>";
		msgText += "<th>상품명</th>";
		msgText += "<th>가격</th>";
		msgText += "</tr>";
		msgText += "<tr>";
		msgText += "<th>운동화</th>";
		msgText += "<th><span style='color:red;font-weight:bold'>20,000원</th>";
		msgText += "</tr>";
		msgText += "</table>";
		
		//받는 사람 
		InternetAddress[] address = { new InternetAddress(to) };
		
		/* 수인인 여러명
		InternetAddress[] address = {  new InternetAddress(to)
									  ,new InternetAddress(to1)
									  ,new InternetAddress(to2) };
		*/
		Message msg = new MimeMessage(sess);
		
		//받는사람
		msg.setRecipients(Message.RecipientType.TO, address);
		//보내는사람
		msg.setFrom(new InternetAddress(from));
		//메일 제목
		msg.setSubject(subject);
		//메일 내용
		msg.setContent(msgText, "text/html; charset=UTF-8");
		//보낸날짜
		msg.setSentDate(new Date());		
		//메일 전송
		Transport.send(msg);
		out.println(to + "님에게 메일을 발송했습니다." );
	}catch(Exception e){
		out.println("<p>메일 전송 실패" + e + "</p>");
		out.println("<p><a href='javascript:history.back();'>[다시시도]</a></p>");
	}//try end
%>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>