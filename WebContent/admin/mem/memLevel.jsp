<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>mem/memList.jsp</title>
<style>
table {
	width: 80%;
	border: 1px solid #ffffff;
	border-collapse: collapse;
	margin: auto;
}

td, th {
	border: 1px solid #444444;
}
</style>
</head>
<body>
	<h3>* 회원 등급 조정 *</h3>
	전체 회원수 :
	<strong><%=dao.count(col, word) + "명"%></strong>
	<hr>
	<table>
		<tr style="text-align: center; background:bisque;">
			<th>아이디</th>
			<th>비번</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입일</th>
			<th>등급</th>
			<th>등급변경</th>
		</tr>
		<%
		int recordPerPage = 10;
		
		int totalRecord = dao.count(col, word);
		
			ArrayList<MemberDTO> list = dao.list(col, word, nowPage, recordPerPage);
			if (list == null) {
				out.println("<tr><td colspan='8'>자료없음</td></tr>");
			} else {
				for (int idx = 0; idx < list.size(); idx++) {
					dto = list.get(idx);
					String mlevel = dto.getMlevel();
		%>
		<tr style="text-align: center; background:cornsilk;">
			<td><%=dto.getId()%></td>
			<td><%=dto.getPasswd()%></td>
			<td><%=dto.getMname()%></td>
			<td><%=dto.getTel()%></td>
			<td><%=dto.getEmail()%></td>
			<td><%=dto.getMdate()%></td>
			<td><%=dto.getMlevel()%></td>
		
		
		<!-- 회원등급 변경 -->
			<td>
			<form action="memLevelProc.jsp">
			<input type="hidden" name="id" value="<%=dto.getId()%>">
			  <select name="mlevel" onchange="levelChange(this.form)">
			    <option value="A1" <%if(mlevel.equals("A1")){out.print("selected");} %>> 최고관리자
			    <option value="B1" <%if(mlevel.equals("B1")){out.print("selected");} %>> 중간관리자
			    <option value="C1" <%if(mlevel.equals("C1")){out.print("selected");} %>> 우수회원
			    <option value="D1" <%if(mlevel.equals("D1")){out.print("selected");} %>> 일반회원 
			    <option value="E1" <%if(mlevel.equals("E1")){out.print("selected");} %>> 비회원
			    <option value="F1" <%if(mlevel.equals("F1")){out.print("selected");} %>> 탈퇴회원
			    <option value="X1" <%if(mlevel.equals("X1")){out.print("selected");} %>> 휴먼계정
			  </select>
			</form>
			</td>
			</tr>

		<%
			} //for end
		%>
		<!-- 정렬 -->
		<tr>
			<td colspan="8">
				<form action="memLevel.jsp">
					<select name="col" onchange="sort(this.form)">
						<option value="id" <%if(col.equals("id") || col.equals("")){out.print("selected");} %>>ID순
						<option value="mname" <%if(col.equals("mname")){out.print("selected");} %>>이름순
						<option value="mdate" <%if(col.equals("mdate")){out.print("selected");} %>>가입일순
						<option value="mlevel" <%if(col.equals("mlevel")){out.print("selected");} %>>등급순
					</select>
				</form>
			</td>
		</tr>
		<!-- 검색 -->
				<tr>
			<td colspan="8" style="text-align:center; height:20px;">
			<form method="get" action="memLevel.jsp" onsubmit="return searchCheck(this)">
			  <select name="col" class="checkbox1">
				<option value="id">아이디
				<option value="mname">이름
				<option value="email">이메일
				<option value="mdate">가입일
				<option value="mlevel">등급
		   	  </select>
		   	  <input type="text" name="word" class="textbox1">
		   	  <input type="submit" value="검색" class="button2"> 
			</form>
		</td>
		</tr>
		<!-- 검색끄읏 -->
		<%
			} //if end
		%>
		
		
	</table>
	
		<script>
			function sort(f) {
				f.submit();
			}//sort end
			
			function levelChange(f){
				var message = "회원 등급을 변경할까요?";
				if(confirm(message)){
					f.submit();
				}//if end
			}//levelChange end
		</script>
</body>
</html>


