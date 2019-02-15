package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.Utility;

public class BbsDel implements CommandAction{
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
		int res = dao.delete(article);
		 
		
		
		String root = Utility.getRoot();
		String msg = "";
		if(res==1) {
			msg += "<script>";
			msg += " alert('글 삭제 성공');";
			msg += "</script>";
			msg += "<meta http-equiv='refresh' content='0;url=" + root + "/bbs2/bbslist.do'>";
		}else {
			msg += "<script>";
			msg += " alert('글 삭제 실패');";
			msg += " location.href='bbslist.do' ;";
			msg += "</script>";
		}//if end
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("res", res);
		req.setAttribute("root", root);
		req.setAttribute("msg", msg);
		
		
		//return "bbsdel.jsp";
		return "bbsResult.jsp";
	}
	
}//class end
