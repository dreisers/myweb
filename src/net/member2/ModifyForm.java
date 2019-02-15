package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class ModifyForm implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		MemberDTO dto = new MemberDTO();
		
		//세션 정보 가져오기
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("s_id"); 
		String passwd = req.getParameter("passwd").trim();
		
		dto.setId(id);
		dto.setPasswd(passwd);
		
		
		MemberDAO dao = new MemberDAO();
		dao.modify(id);
		
		req.setAttribute("id", id);
		req.setAttribute("passwd", passwd);
		System.out.println(id);
		System.out.println(passwd);
		return "modifyform.jsp";
		
	}
	
}//class end
