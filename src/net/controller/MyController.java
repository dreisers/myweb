package net.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class MyController extends HttpServlet {
	
	private Map commandMap = new HashMap();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		String props = config.getInitParameter("propertyConfig");
		Properties pr = new Properties();
		FileInputStream f = null;
		
		try {
			f = new FileInputStream(props);
			pr.load(f);
		}catch (IOException e) {
			System.out.println(e);
		}finally {
			if(f != null) try { f.close(); } catch(Exception ex) {}
		}//try end
		
		Iterator keyIter = pr.keySet().iterator();
		while(keyIter.hasNext()) {
			String key = (String)keyIter.next();
			String value = pr.getProperty(key);
			//System.out.println(key);
			//System.out.println(value);
			try {
				
			Class commandClass = Class.forName(value);
			Object commandInstance = commandClass.newInstance();
			commandMap.put(key, commandInstance);
			}catch (Exception e) {
				System.out.println(e);
			}//try end
		}//while end
		
	}//init end

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}//doGet end
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}//doPost end
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = null;
		CommandAction com = null;
		try {
			String command = req.getRequestURI();
			com = (CommandAction)commandMap.get(command);
			view = com.requestPro(req, resp);
		} catch (Throwable e) {
			throw new ServletException(e);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher(view);
		dispatcher.forward(req, resp);
		
	}//process end
}//class end
