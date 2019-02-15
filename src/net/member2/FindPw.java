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
		
		//2) ���ϼ������� �������� ���� ����/���
		Authenticator myAuth = new MyAuthenticator();
		//3) 1)�� 2)�� ��ȿ���� ����
	    Session sess = Session.getInstance(props, myAuth);
		//out.print("���� ���� ���� ����");
		
		try{
			//4) ���Ϻ�����
			//	 �޴»��, �����»��, ����, ��������
			//	 ����, ����, ������¥
			req.setCharacterEncoding("UTF-8");
			String from = "test@test.com";
			String subject = "�ӽú�й�ȣ �߼�";
			String msgText = "";
			
			//���� 
			
			msgText += dto.getId();
			msgText += " ���� �ӽ� ��й�ȣ�� ";
			msgText += dto.getPasswd();
			msgText += " �Դϴ� �α��� �� ��й�ȣ�� �������ּ���";
			
			//�޴� ��� 
			InternetAddress[] address = { new InternetAddress(email) };
			
			Message msg = new MimeMessage(sess);
			
			//�޴»��
			msg.setRecipients(Message.RecipientType.TO, address);
			//�����»��
			msg.setFrom(new InternetAddress(from));
			//���� ����
			msg.setSubject(subject);
			//���� ����
			msg.setContent(msgText, "text/html; charset=UTF-8");
			//���� ����
			Transport.send(msg);
			System.out.println(email + "���� �ӽù�ȣ�� �߼��߽��ϴ�." );
			System.out.println("<p><a href='loginForm.jsp;'>[�α��� ȭ��]</a></p>");
		}catch(Exception e){
			
			System.out.println("<p>���� ���� ����" + e + "</p>");
			System.out.println("<p><a href='javascript:history.back();'>[�ٽýõ�]</a></p>");
		}//try end
		
		
		return "findpwpro.jsp";
	}
	
}//class end
