package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class DupCheckPro implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		MemberDAO dao = new MemberDAO();
		String check = req.getParameter("check").trim();
		
		int cnt=0; 		
		
		String pageName = req.getRequestURI();
		pageName = pageName.substring(pageName.lastIndexOf("/")+1, pageName.length());
		
		if(pageName.equals("idcheckPro.do")) {
			req.setAttribute("action", "아이디");
			cnt = dao.duplecateID(check); 
		}else if(pageName.equals("emailcheckPro.do")) {
			req.setAttribute("action", "이메일");
			cnt = dao.duplecateEmail(check);
		}
		  
		  req.setAttribute("cnt", cnt);
		  req.setAttribute("check", check);
		return "dupcheckpro.jsp";
	}
	
}//class end
