package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class DupCheck implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
			
		String pageName = req.getRequestURI(); //현재 페이지명 가져오기
		pageName = pageName.substring(pageName.lastIndexOf("/")+1, pageName.length());
		System.out.println(pageName);
		if(pageName.equals("idcheckForm.do")) {
			req.setAttribute("action", "아이디");
		}else if(pageName.equals("emailcheckForm.do")) { 
			req.setAttribute("action", "이메일");
		}
				
		return "dupcheck.jsp";
	}
	
}//class end
