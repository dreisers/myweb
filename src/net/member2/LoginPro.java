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
		
		if(res==1) { //로그인 성공
			//세션객체 생성
			HttpSession session = req.getSession();
			session.setAttribute("s_id", id);
			session.setAttribute("s_passwd", passwd);
			
		
			// 아이디 저장
			String c_id = req.getParameter("c_id");
			if(c_id==null) { //체크하지 않은 경우
				c_id = "";
			}
			
			Cookie cookie = null;
			if(c_id.equals("SAVE")) {
				cookie = new Cookie("c_id", id); //(쿠키번수명,값)
				cookie.setMaxAge(60*60*24*30); //1달 동안 쿠키저장
			}else {
				cookie = new Cookie("c_id", "");
				cookie.setMaxAge(0);
			}
			
			resp.addCookie(cookie); //사용자pc에 쿠키값 저장
			
		
			
		}//if end
		
		req.setAttribute("res", res);
		
		return "loginPro.jsp";
	}
	
}//class end
