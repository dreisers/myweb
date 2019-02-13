package net.bbs2;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.Utility;


public class UpdateForm implements CommandAction{
	
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
				
		BoardDataBean article = new BoardDataBean(); //DTO
		
		int num = Integer.parseInt(req.getParameter("num"));
		String passwd = req.getParameter("passwd");
		String writer = req.getParameter("writer");
		String subject = req.getParameter("subject");
		String email = req.getParameter("email");
		String content = req.getParameter("content");
		String pageNum = req.getParameter("pageNum");
		
		article.setNum(num);
		article.setPasswd(passwd);
		article.setWriter(writer);
		article.setSubject(subject);
		article.setEmail(email);
		article.setContent(content);
		
//		System.out.println(article);
		BoardDBBean dao = new BoardDBBean();  //DAO
		int res = dao.updateproc(article);
		
		String root = Utility.getRoot();
		String msg = "";
		if(res==1) {
			msg += "<script>";
			msg += " alert('글 수정 성공')";
			msg += "</script>";
			msg += "<meta http-equiv='refresh' content='0;url=" + root + "/bbs2/bbslist.do'>";
		}else {
			msg += "<!DOCTYPE html>";
			msg += "<html><body>";
			msg += "<script>";
			msg += " alert('글 수정 실패')";
			msg += " history.go(-1)";
			msg += "</script>";
			msg += "</body></html>";
		}//if end
		
		
		req.setAttribute("num", num);
		req.setAttribute("passwd", passwd);
		req.setAttribute("writer", writer);
		req.setAttribute("subject", subject);
		req.setAttribute("email", email);
		req.setAttribute("content", content);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("res", res);
		req.setAttribute("root", root);
		req.setAttribute("msg", msg);		
		
//		System.out.println(writer);
//		System.out.println(passwd);
//		System.out.println(res);
		//return "updateproc.jsp";
		return "bbsResult.jsp";
	}//requestPro end
	
}//class end
