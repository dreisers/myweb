package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;


public class CreateForm implements CommandAction{
	
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		
		
		return "createForm.jsp";
		
		//2) View페이지 재구성
		/*
		String root = Utility.getRoot();
		String msg = "<meta http-equiv='refresh' content='0;url=" + root + "/bbs2/bbslist.do'>";
		req.setAttribute("msg", msg);
		
		//자주 쓰이는 문법
		//msg += "<script>";
		//msg += "alert('성공')";
		//msg += "</script>";
		
		return "bbsResult.jsp";
		*/
	}//requestPro end
	
}//class end