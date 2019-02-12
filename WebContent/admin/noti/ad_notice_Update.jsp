<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noti/ad_notice_Update.jsp</title>
</head>
<body>
<%
int noticeno=Integer.parseInt(request.getParameter("noticeno"));


dto.setNoticeno(noticeno);

dto=dao.updateform(dto);
if(dto==null){
	  out.println("<script>");
	  out.println("  alert('비밀번호가 일치하지 않습니다.');");
	  out.println("  history.back();");
	  out.println("</script>");
	}else{
%>
	<form name="noticefrm" method="post" action="ad_notice_UpProc.jsp">
		<input type="hidden" name="noticeno" value="<%=request.getParameter("noticeno") %>">
		<input type="hidden" name="col" value="<%=col%>">
		<input type="hidden" name="word" value="<%=word%>">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<table style="margin:0 auto; text-align:center">
				<tr>
					<th>제목</th>
						<td>
							<input type="text" name="subject" size="38" value="<%=dto.getSubject()%>">
						</td>
				</tr>
				<tr>
					<th>내용</th>
						<td>
						<textarea rows="10" cols="40" name="content"><%=dto.getContent()%></textarea>
						</td>
				</tr>		
				<tr>
	    				<td colspan="2" align="center">
	      					<input type="submit" value="쓰기">
	      					<input type="reset" value="취소">
	    				</td>
				</tr> 
			</table>
	</form>
<% }//if end %>
</body>
</html>


