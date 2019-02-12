<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminauth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noti/ad_notice_List.jsp</title>
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
	<h3>* 공지 목록 *</h3>
	글 갯수 :
	<strong><%=dao.count(col, word) + "개"%></strong>
	<hr>
	<table>
		<tr style="text-align: center; background: bisque;">
			<th>글번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>숨기기</th>
			<th>삭제</th>
		</tr>
		<%
			int recordPerPage = 10;

			int totalRecord = dao.count(col, word);

			ArrayList<NoticeDTO> list = dao.list(col, word, nowPage, recordPerPage);
			if (list == null) {
				out.println("<tr><td colspan='8'>자료없음</td></tr>");
			} else {
				for (int idx = 0; idx < list.size(); idx++) {
					dto = list.get(idx);
		%>
			<tr id="showHide">
		 <form name="check1" onsubmit="return checked(this)">
				<td><%=dto.getNoticeno()%></td>
				<td><a href="ad_notice_Read.jsp?noticeno=<%=dto.getNoticeno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject()%></a></td>
				<td><%=dto.getRegdt()%></td>
				<td><%=dto.getReadcnt()%></td>
				<td><input type="checkbox" name="check" id="check" value=""></td>
		</form>
		<form action="ad_notice_DelProc.jsp">
				<td>
						<input type="hidden" name="noticeno" value="<%=dto.getNoticeno()%>">
						<input type="button" name="delete" value="삭제" onclick="mdelete(this.form)">
				</td>
			</tr>
		</form>
<%	
} //for end 
%>
		<!-- 검색 -->
		<tr>
			<td colspan="7" style="text-align: center; height: 20px;">
				<form method="get" action="ad_notice_List.jsp" onsubmit="return searchCheck(this)">
					<select name="col" class="checkbox1">
						<option value="subject">제목
					</select>
					 <input type="text" name="word" class="textbox1">
					 <input type="submit" value="검색" class="button2"> 
					 <input type="button" value="글쓰기" class="button2" onclick="window.location='ad_notice_Form.jsp';">
					 <input type="button" value="적용" onclick="showHide(this)">
				</form>
			</td>
		</tr>
		<!-- 검색끄읏 -->
		<%
			} //if end
		%>
		
	</table>
	<script>
		function mdelete(f) {
			var message = "삭제 하시겠습니까?"
			if (confirm(message)) {
				f.submit();
			}//if end
		}//mdelete end

		function mupdate(f) {
			var message = "수정 하시겠습니까?"
			if (confirm(message)) {
				f.submit();
			}//if end
		}//mdelete end

		function checked(){
			var chk1 = document.check1.check.checked;
			if(!chk1) {
				var showcheck = false; 
				var hidecheck = true;
				return false;
			}
		}//check end
		
		 function showHide(){
		        if(document.getElementById("showHide").style.display =='none'){
		            document.getElementById("showHide").style.display ='table-row';
		        }
		        else{
		            document.getElementById("showHide").style.display ='none';
		        }
		    }//showHide end
	</script>
</body>
</html>


