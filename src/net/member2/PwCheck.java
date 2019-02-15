package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class PwCheck implements CommandAction{

	// 비밀번호 입력 받는 폼
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		String page = req.getParameter("page").trim();
		 
		req.setAttribute("page", new String(page));
		
		return "pwcheck.jsp";
	}

}//class end
