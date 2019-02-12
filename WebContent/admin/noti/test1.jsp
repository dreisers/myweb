<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <title>check박스 체크 여부 확인하기</title>
 
  <script type="text/javascript">
    function CheckForm(){
        
        //체크박스 체크여부 확인 [하나]
        var chk1=document.frmJoin.U_checkAgreement1.checked;
        
        if(!chk1){
            alert('약관1에 동의해 주세요');
            return false;
        } 
		var chk2=document.frmJoin.check.checked;
		
		if(!chk2){
			alert("test");
			return false;
		}
    }


 </script>
 </head>
 <body>
 
  
<form name="frmJoin" action=""  onSubmit="return CheckForm(this)">
    <input type="checkbox" name="U_checkAgreement1" id="U_checkAgreement1" value="" /> 약관동의
	<input type="checkbox" name="check" id="check" value="" /> 약관동의
    <input type="submit" value="전송">
</form>

 </body>
</html>