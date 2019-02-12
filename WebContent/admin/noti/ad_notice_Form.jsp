<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noti/ad_notice_Form.jsp</title>
</head>
<body>
	<form name="ad_notifrm" method="post" action="ad_notice_Ins.jsp">
		<table style="margin:0 auto; text-align:center">
			<tr>
				<th class="form">제목</th>
					<td>
						<input type="text" name="subject" size="38">
					</td>
			</tr>
			<tr>
				<th class="form">내용</th>
					<td>
					<textarea rows="10" cols="40" name="content"></textarea>
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
</body>
</html>


