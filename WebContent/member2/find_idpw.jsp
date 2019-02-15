<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='../header.jsp'%>
<!--  본문시작 -->
		<p>* 아이디 찾기 *</p>
		<form method = "get" action="findid.do">
<table style="margin:0 auto; text-align:center">
<tr>
    <th>이름</th>
    <td><input type="text" name="mname" size="10"></td>
    <th>이메일</th>
    <td><input type="text" name="email" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
		<input type="button" name="fid" class="button2" value="찾기" onclick="idfindCheck(this.form)">
        <input type="button" value="취소" class="button2" onclick="javascript:history.back();"/>
    </td>
</tr> 
</table>
</form>
<hr>
	<p> - 비밀번호 찾기 - </p>
<form method = "get" action="findpw.do">
<table style="margin:0 auto;">
<tr>
	<th>아이디</th>
	<td><input type="text" name="id" size="10"></td>
    <th>이름</th>
    <td><input type="text" name="mname" size="10"></td>
    <th>번호</th>
    <td><input type="text" name="tel" size="10"></td>
    <th>이메일</th>
    <td><input type="text" name="email" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="button" name="fpw" class="button2" value="찾기" onclick="pwfindCheck(this.form)">
      <input type="button" class="button2" value="취소" onclick="javascript:history.back();"/>  
    </td>
</tr> 
</table>
</form>
	
	<script>
			function idfindCheck(f) { //이름 & 이메일 유효성검사
				var message = "아이디 찾기"
					if(confirm(message)){
						f.submit();
					}//if end
				}//mdelete end
				
				function pwfindCheck(f) { //이름 & 이메일 유효성검사
					var message = "비밀번호 찾기"
						if(confirm(message)){
							f.submit();
						}//if end
					}//mdelete end
		</script>
	
	
<!--  본문끝 -->
<%@ include file='../footer.jsp'%>