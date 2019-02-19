package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class ModifyPro implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		MemberDTO dto = new MemberDTO();
		
		String id = req.getParameter("id").trim();
		String passwd=req.getParameter("passwd").trim();
		String mname=req.getParameter("mname").trim();
		String tel =req.getParameter("tel").trim();
		String email=req.getParameter("email").trim();
		String zipcode=req.getParameter("zipcode").trim();
		String address1=req.getParameter("address1").trim();
		String address2=req.getParameter("address2").trim();
		String job=req.getParameter("job");

		dto.setId(id);
		dto.setPasswd(passwd);
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setZipcode(zipcode);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		dto.setJob(job);
		
		
		
		MemberDAO dao = new MemberDAO();
		
		int res = dao.modifyproc(dto); 
		
		req.setAttribute("res", res);
		req.setAttribute("passwd", passwd);
		req.setAttribute("mname", mname);
		req.setAttribute("tel", tel);
		req.setAttribute("email", email);
		req.setAttribute("zipcode", zipcode);
		req.setAttribute("address1", address1);
		req.setAttribute("address2", address2);
		
		return "modifypro.jsp";
		
	}
	
}//class end
