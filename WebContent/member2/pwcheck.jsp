<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>

<!--  본문시작 -->
<form method="post" action="${page }.do" onsubmit="return pwCheck(this)">
	<table style="margin: 0 auto; text-align: center">
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="10"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="button2" value="확인">
				<input type="button" class="button2" value="취소" onclick="javascript:history.back();" />
			</td>
		</tr>
	</table>
</form>


<script>
function pwCheck(f) { //유효성검사 해야됨
	
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 6) {
		alert("비밀번호는 6글자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}
		return true;


}// pwCheck end
</script>

<!--  본문끝 -->
<%@ include file='../footer.jsp'%>