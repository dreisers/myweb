<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<%
//로그인을 하지 않은 경우
if(s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("guest"))
{ 
	//쿠키값 가져오기 
	Cookie[] cookies = request.getCookies();
	String c_id = "";
	if(cookies!=null){ //쿠키가 존재하는지?
		for(int idx=0; idx<cookies.length; idx++){
			Cookie cookie = cookies[idx];
			if(cookie.getName().equals("c_id")==true){ //쿠키변수(c_id)가 있는지?
			c_id = cookie.getValue();
			}
		}//for end
	}//if end
%>
<form name="loginFrm" method="post" action="loginProc.jsp"
	onsubmit="return loginCheck(this)">
	<table align="center">
		<tr>
			<td><input type="text" name="id" id="id" value="<%=c_id%>"
				placeholder="아이디" required="required"></td>
			<td>
			<td rowspan="2"><input type="image" src="../images/bt_login.gif"
				style="cusor: pointer"></td>
		</tr>
		<tr>
			<td><input type="password" name="passwd" id="passwd"
				placeholder="패스워드" required="required"></td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				<p>
					<input type="checkbox" name="c_id" value="SAVE"
						<%if(!(c_id.isEmpty())){out.print("checked");}%>>아이디저장
					&nbsp;&nbsp; <a href="agreement.jsp">회원가입</a> &nbsp;&nbsp; <a href="find_idpw.jsp">아이디/비번찾기</a>
				</p>
			</td>
		</tr>
	</table>
</form>
<%
}else{
	//로그인 성공한 경우
	out.println("<stong>" + s_id + "</strong>님");
	out.println("<a href='logout.jsp'>[로그아웃]</a>");
	out.println("<br><br>");
	out.println("<a href='memUpdate.jsp'>[회원정보수정]</a>");
	out.println("<a href='memDel.jsp'>[회원탈퇴]</a>");
}//if end
%>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>