package net.member2;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class LoginPro implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		String id = req.getParameter("id").trim();
		String passwd = req.getParameter("passwd").trim();
		
		MemberDAO dao = new MemberDAO();
		int res = dao.login(id, passwd);
		
		if(res==1) { //�α��� ����
			//���ǰ�ü ����
			HttpSession session = req.getSession();
			session.setAttribute("s_id", id);
			session.setAttribute("s_passwd", passwd);
			
		
			// ���̵� ����
			String c_id = req.getParameter("c_id");
			if(c_id==null) { //üũ���� ���� ���
				c_id = "";
			}
			
			Cookie cookie = null;
			if(c_id.equals("SAVE")) {
				cookie = new Cookie("c_id", id); //(��Ű������,��)
				cookie.setMaxAge(60*60*24*30); //1�� ���� ��Ű����
			}else {
				cookie = new Cookie("c_id", "");
				cookie.setMaxAge(0);
			}
			
			resp.addCookie(cookie); //�����pc�� ��Ű�� ����
			
		
			
		}//if end
		
		req.setAttribute("res", res);
		
		return "loginPro.jsp";
	}
	
}//class end
