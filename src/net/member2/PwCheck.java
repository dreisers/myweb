package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class PwCheck implements CommandAction{

	// ��й�ȣ �Է� �޴� ��
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		String page = req.getParameter("page").trim();
		 
		req.setAttribute("page", new String(page));
		
		return "pwcheck.jsp";
	}

}//class end
