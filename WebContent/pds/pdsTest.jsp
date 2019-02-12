<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>pdsTest.jsp</title>
</head>
<body>
 <h3> * 파일 첨부 테스트</h3>					<!-- 파일 첨부시 필수 -->
 <form action="pdsTestProc.jsp" method="post" enctype="multipart/form-data">
 	이름 : <input type="text" name="uname"><br>
 	제목 : <input type="text" name="subject"><br>
 	내용 : <textarea rows="5" cols="20" name="content"></textarea><br>
 	첨부 : <input type="file" name="filenm"><br>
 	<input type="submit" value="전송">

 </form>

</body>
</html>