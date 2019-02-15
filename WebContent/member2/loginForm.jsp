<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
<p> * 로 그 인 * </p> 

<c:if test="${empty sessionScope.s_id }">
<%
	Cookie[] cookies = request.getCookies(); //쿠키값 가져오기
	String c_id = "";
	if(cookies!=null){ //쿠키가 존재하는지?
		for(int idx=0; idx<cookies.length; idx++){
			Cookie cookie = cookies[idx];
			if(cookie.getName().equals("c_id")==true){ //쿠키변수(c_id)가 있는지?
			c_id = cookie.getValue(); // 쿠키값 가져오기
			}
		} //for end
	} //if end
%>
<form name="loginFrm" method="post" action="./loginPro.do" onsubmit="return loginCheck(this)">
	<table align="center">
		<tr>
			<td><input type="text" name="id" id="id" value="<%=c_id%>" placeholder="아이디" required="required"></td>
			<td rowspan="2"><input type="image" src="../images/bt_login.gif" style="cusor: pointer"></td>	
		</tr>
		<tr>
			<td><input type="password" name="passwd" id="passwd" placeholder="패스워드" required="required"></td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				<p><input type="checkbox" name="c_id" value="SAVE" <%if(!(c_id.isEmpty())){out.print("checked");}%>>아이디저장
					 &nbsp;&nbsp;
					<a href="agreement.jsp">회원가입</a>
					 &nbsp;&nbsp;
					<a href="find_idpw.do">아이디/비번찾기</a>
				</p>
			</td>
		</tr>
	</table>
</form>
</c:if>

<c:if test="${sessionScope.s_id != null }">
	<stong>${sessionScope.s_id}</strong>님
	<a href='logout.do'>[로그아웃]</a>
	<br><br>
	<a href='pwcheck.do?page=modifyForm'>[회원정보수정]</a>
	<a href='pwcheck.do?page=withdrawForm'>[회원탈퇴]</a>
</c:if>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>