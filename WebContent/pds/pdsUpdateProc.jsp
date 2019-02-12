<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<p><a href="pdsList.jsp">[글목록]</a></p>
<%


try{
	String saveDir = application.getRealPath("/upload");
	int maxPostSize = 1024 * 1024 * 10; //10Mb
	String encoding = "UTF-8";
	
	
	//사용자가 전송한 텍스트 정보 및 파일 저장하기
	MultipartRequest mr = new MultipartRequest(request, saveDir
											   , maxPostSize, encoding
											   , new DefaultFileRenamePolicy()
											   );

	
	//값을 받아온다
	int pdsno=Integer.parseInt(mr.getParameter("pdsno"));
	String wname = mr.getParameter("wname").trim();
	String subject = mr.getParameter("subject").trim();
	String passwd = mr.getParameter("passwd").trim();
	
	
	 //파일 업로드 (다중)
	 String item = "";
	 String ofileName = "";
	 String fileName = "";
	 File file = null;
	 
	 Enumeration files = mr.getFileNames();
	 
	 int idx=1;
	 // 파일 가져오기
	 while(files.hasMoreElements()){
		 
		 
		 item = (String)files.nextElement(); // filenm1
		 fileName = mr.getFilesystemName(item);
		 ofileName = mr.getOriginalFileName(item);
		
		 
		 if(fileName!=null){ //파일 수정할때 
			 file = mr.getFile(item); // 파일담기
			 
			 if(file.exists()){ // 파일 존재여부
				 long filesize = file.length();
			 
			 	dto.setWname(wname);
		 	 	dto.setSubject(subject);
		 	 	dto.setPasswd(passwd);
		 	 	dto.setFilename(fileName);
			 	dto.setFilesize(filesize);
			 	dto.setPdsno(pdsno);
			 	
			 	int res = dao.updateproc(dto, saveDir);
			 	
			 	if(res==0){
			 		  out.print("사진변경 실패<br/>");
					  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
					}
					else {
					  out.print("<script>");
					  out.print("  alert('사진변경 성공');");
					  out.print("  window.location='pdsList.jsp'");
					  out.print("</script>");
					}			 
				
			 }//if end
			 
			 
		 }else {    //파일 수정안할때
 				dto.setWname(wname);
 				dto.setSubject(subject);
 				dto.setPasswd(passwd);
				dto.setPdsno(pdsno);
				
				
			 	int res=dao.updateproc(dto); 
			 	
				if(res==0){ 
				  out.print("사진변경 실패<br/>");
				  out.print("<a href='javascript:history.back();'>[다시시도]</a>");
				}
				else {
				  out.print("<script>");
				  out.print("  alert('사진변경 성공');");
				  out.print("  window.location='pdsList.jsp'");
				  out.print("</script>");
				}			 
			
			 
		 }
	 }//while end
	 
}catch(Exception e){
	out.print(e);
	out.print("<p>파일 업로드 실패</p>");
	out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	
}//try end

%>



<!--  본문끝 -->
<%@ include file='../footer.jsp'%>