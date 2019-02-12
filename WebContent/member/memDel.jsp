<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='ssi.jsp' %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
	<h1>*회 원 탈 퇴 *</h1>
	<form method = "get" action="memDelProc.jsp" onsubmit="return memDelCheck(this)">  
<table style="margin:0 auto; text-align:center">
<tr>
    <th>비밀번호</th>
    <td><input type="password" name="passwd" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" class="button2" value="확인">
      <input type="button" class="button2" value="취소" onclick="javascript:history.back();"/>
    </td>
</tr> 
</table>
</form>


<script>
function memDelCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호는 4글자 이상 입력해주세요");
		f.passwd.focus();
		return false;
	}

	var msg = "탈퇴하시겠습니까?";
	if (confirm(msg)) {
		return true;
	} else {
		return false;
	}
}// pwCheck end
</script>
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>