package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;


public class CreateForm implements CommandAction{
	
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		
		
		return "createForm.jsp";
		
		//2) View������ �籸��
		/*
		String root = Utility.getRoot();
		String msg = "<meta http-equiv='refresh' content='0;url=" + root + "/bbs2/bbslist.do'>";
		req.setAttribute("msg", msg);
		
		//���� ���̴� ����
		//msg += "<script>";
		//msg += "alert('����')";
		//msg += "</script>";
		
		return "bbsResult.jsp";
		*/
	}//requestPro end
	
}//class end