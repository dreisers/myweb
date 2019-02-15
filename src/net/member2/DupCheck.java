package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class DupCheck implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
			
		String pageName = req.getRequestURI(); //���� �������� ��������
		pageName = pageName.substring(pageName.lastIndexOf("/")+1, pageName.length());
		System.out.println(pageName);
		if(pageName.equals("idcheckForm.do")) {
			req.setAttribute("action", "���̵�");
		}else if(pageName.equals("emailcheckForm.do")) { 
			req.setAttribute("action", "�̸���");
		}
				
		return "dupcheck.jsp";
	}
	
}//class end
