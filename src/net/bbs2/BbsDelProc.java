package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsDelProc implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		BoardDataBean article = new BoardDataBean();
		
		int num = Integer.parseInt(req.getParameter("num"));
		String passwd = req.getParameter("passwd");
		String pageNum = req.getParameter("pageNum"); 
		
		article.setNum(num);
		article.setPasswd(passwd);
		
		BoardDBBean dao = new BoardDBBean();
		int res = dao.delete(article);
		 
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("res", res);
		
		return "deleteProc.jsp";
	}

}//class end
