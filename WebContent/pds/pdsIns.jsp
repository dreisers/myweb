<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>

<!--  본문시작 -->
	<h3> * 사진 올리기 결과 * </h3>
<%
	try{
		//1) 첨부된 파일 저장
		String saveDirectory = application.getRealPath("/upload");
		int maxPostSize = 1024 * 1024 * 10; //10Mb
		String encoding = "UTF-8";
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory
												   , maxPostSize, encoding
												   , new DefaultFileRenamePolicy()
												   );			
		
		//2) 저장된 파일명, 파일크기 가져오기		
		 String item = "";
		 String fileName = "";
		 long filesize = 0;
		 File file = null;
		 
		 Enumeration files = mr.getFileNames();
		 
		 int idx=1;
		 while(files.hasMoreElements()){
			 item = (String)files.nextElement(); 
			 fileName = mr.getFilesystemName(item);
			 if(fileName!=null){
				 file = mr.getFile(item); // 파일담기
				 if(file.exists()){ // 파일 존재여부
					 filesize = file.length();
				 }//if end
			 }//if end
		 }//while end
		//3) tb_pds 테이블에 저장하기
		String wname = mr.getParameter("wname").trim();		
		//wname += "<br>IP : " + request.getRemoteAddr(); 글쓴이 ip조회
		String subject = mr.getParameter("subject").trim();		
		String passwd = mr.getParameter("passwd").trim();		

		dto.setWname(wname);
		dto.setSubject(subject);
		dto.setPasswd(passwd);
		dto.setFilename(fileName);
		dto.setFilesize(filesize);
		
		boolean flag = dao.insert(dto);
		if(flag){
			  out.print("<script>");
			  out.print("  alert('사진을 추가했습니다');");
			  out.print("  window.location='pdsList.jsp';");
			  out.print("</script>");
			}
			else {
		  	  out.println("<p>사진 추가 실패</p>");
			  out.println("<a href='javascript:history.back()'>[다시시도]");
			}
	}catch(Exception e){
		out.println(e);
		out.println("<p>사진 올리기 실패</p>");
		out.println("<a href='javascript:history.back()'>[다시시도]");
	}//try end

%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>