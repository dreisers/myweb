package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsUpdate implements CommandAction{

	// 비밀번호를 입력받아서 삭제 진행 시켜주는 폼 
	
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		BoardDataBean article = new BoardDataBean();
		
		int num = Integer.parseInt(req.getParameter("num"));
		String passwd = req.getParameter("passwd");
		String pageNum = req.getParameter("pageNum"); 
		
		
		article.setNum(num);
		article.setPasswd(passwd);
		
		BoardDBBean dao = new BoardDBBean();
		article = dao.updateform(article);
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("article", article);
//		System.out.println(passwd);
//		System.out.println(article);
		
		return "bbsUpdate.jsp";
	}

}//class end
