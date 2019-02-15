package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class WithdrawForm implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		MemberDTO dto = new MemberDTO();
		String passwd = req.getParameter("passwd").trim();
		
		//세션 정보 가져오기
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("s_id"); 

		dto.setId(id);	
		dto.setPasswd(passwd);
		
		MemberDAO dao = new MemberDAO();
		int res= dao.delete(id, passwd);
		
		req.setAttribute("id", id);
		req.setAttribute("passwd", passwd);
		req.setAttribute("res", res);
		System.out.println(res);
		return "withdrawform.jsp";
	}
	
}//class end
