package net.member2;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.MyAuthenticator;

public class FindPw implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
			
		MemberDTO dto = new MemberDTO();
		String id = req.getParameter("id").trim();
		String tel = req.getParameter("tel").trim();
		String mname = req.getParameter("mname").trim();
		String email = req.getParameter("email").trim();

		dto.setId(id);
		dto.setTel(tel);
		dto.setMname(mname);
		dto.setEmail(email); 
		
		MemberDAO dao = new MemberDAO();
		dto = dao.find_pw(dto);
		
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
			req.setCharacterEncoding("UTF-8");
			String from = "test@test.com";
			String subject = "임시비밀번호 발송";
			String msgText = "";
			
			//내용 
			
			msgText += dto.getId();
			msgText += " 님의 임시 비밀번호는 ";
			msgText += dto.getPasswd();
			msgText += " 입니다 로그인 후 비밀번호를 변경해주세요";
			
			//받는 사람 
			InternetAddress[] address = { new InternetAddress(email) };
			
			Message msg = new MimeMessage(sess);
			
			//받는사람
			msg.setRecipients(Message.RecipientType.TO, address);
			//보내는사람
			msg.setFrom(new InternetAddress(from));
			//메일 제목
			msg.setSubject(subject);
			//메일 내용
			msg.setContent(msgText, "text/html; charset=UTF-8");
			//메일 전송
			Transport.send(msg);
			System.out.println(email + "으로 임시번호를 발송했습니다." );
			System.out.println("<p><a href='loginForm.jsp;'>[로그인 화면]</a></p>");
		}catch(Exception e){
			
			System.out.println("<p>메일 전송 실패" + e + "</p>");
			System.out.println("<p><a href='javascript:history.back();'>[다시시도]</a></p>");
		}//try end
		
		
		return "findpwpro.jsp";
	}
	
}//class end
