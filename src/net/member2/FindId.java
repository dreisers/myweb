package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class FindId implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		
		MemberDTO dto = new MemberDTO();
		String mname = req.getParameter("mname").trim();
		String email = req.getParameter("email").trim();
		
		dto.setMname(mname);
		dto.setEmail(email); 
	
		MemberDAO dao = new MemberDAO();
		String id = dao.find_id(mname, email);
		
		req.setAttribute("id", id);
		req.setAttribute("mname", mname);
		req.setAttribute("email", email);
		
		return "findidpro.jsp";
	}
	
}//class end
