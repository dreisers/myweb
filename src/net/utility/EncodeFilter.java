package net.utility;

import java.io.*;
import javax.servlet.*;


public class EncodeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {
			
		arg0.setCharacterEncoding("UTF-8");
		arg2.doFilter(arg0, arg1);
		
	}


	
	
}//class end
