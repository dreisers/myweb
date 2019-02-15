package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;


public class CreatePro implements CommandAction{
	
	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		MemberDTO dto = new MemberDTO(); //DTO
		String id=req.getParameter("id").trim();
		String passwd=req.getParameter("passwd").trim();
		String mname=req.getParameter("mname").trim();
		String tel =req.getParameter("tel").trim();
		String email=req.getParameter("email").trim();
		String zipcode=req.getParameter("zipcode").trim();
		String address1=req.getParameter("address1").trim();
		String address2=req.getParameter("address2").trim();
		String job=req.getParameter("job");
		
		MemberDAO dao = new MemberDAO();
		dto.setId(id);
		dto.setPasswd(passwd);
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setZipcode(zipcode);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		dto.setJob(job);

		int res=dao.createmem(dto); 

		req.setAttribute("res", res);
		
		return "createpro.jsp";
	}//requestPro end
	
}//class end