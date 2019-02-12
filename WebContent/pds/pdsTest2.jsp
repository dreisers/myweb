<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>pdsTest2.jsp</title>
</head>
<body>
 <h3> * 파일 첨부 테스트 (다중)</h3>	
 <form action="pdsTestProc2.jsp" method="post" enctype="multipart/form-data">
 	이름 : <input type="text" name="uname"><br>
 	제목 : <input type="text" name="subject"><br>
 	내용 : <textarea rows="5" cols="20" name="content"></textarea><br>
 	첨부 : <input type="file" name="filenm1"><br>
 	첨부 : <input type="file" name="filenm2"><br>
 	첨부 : <input type="file" name="filenm3"><br>
 	<input type="submit" value="전송">
 </form>

</body>
</html>