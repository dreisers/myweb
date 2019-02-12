<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Theme Made By www.w3schools.com - No Copyright -->
  <title>My Web</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="./css/bootstrap.min.css">
  <link rel="stylesheet" href="./css/myhome.css?after">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/bootstrap.min.js"></script>
  <script src="./js/myscript.js"></script>
  <style>
   .time {
    background-color:#2f2f2f;
    color:#ffff00;
	  border:0; 
	  font:20px; 
	  text-align:center;
	  font-weight:bold;
  }
  #myfilm{
      position:relative;
      left:0px;
      top:10px;
	  background-color:#ffffff;
      width:100%;
      height:100px;
      overflow:hidden;
      margin: 0 auto;
  }   
  </style>
  <script>
   function showtime(){
    var today = new Date();
    var str = "";
  
      str += today.getFullYear() + ".";
      
    if(today.getMonth()+1<10){
      str += "0";
    }
      str += (today.getMonth()+1) + ".";
  
      if(today.getDate()<10) {
         str += "0";
      }       
    str += today.getDate();
  
    switch(today.getDay()) {
      case 0: str += " (일) "; break;
      case 1: str += " (월) "; break;
      case 2: str += " (화) "; break;
      case 3: str += " (수) "; break;
      case 4: str += " (목) "; break;
      case 5: str += " (금) "; break;
      case 6: str += " (토) "; break;
    }
       
    if(today.getHours()<12)  {
           str += "AM ";
    } else {
           str += "PM ";
    }
  
    if(today.getHours()>=13)  {
           str += (today.getHours()-12)+":";
    } else {
           str += today.getHours()+":";
    }
  
    if(today.getMinutes()<10) {
           str += "0";
    } 		
    str += today.getMinutes()+":";
  
    if(today.getSeconds()<10) {
          str += "0";
      } 
      str += today.getSeconds();
  
      document.myform.clock.value = str;
  
      timer1=setTimeout(showtime, 1000); //1초후 showtime함수 호출
    }//showtime() end

    var timer1, timer2; //전역변수

function killtime() {
 clearTimeout(timer1);
 clearTimeout(timer2);
}//killtime() end  

  </script>
  </head>
<body onload="showtime()" onunload="killtime()">

<!-- Navbar -->
<nav class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="<%=request.getContextPath()%>/myhome.jsp">HOME</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./bbs/bbsList.jsp">자유게시판</a></li>
        <li><a href="./notice/noticeList.jsp ">공지사항</a></li>
        <li><a href="./member/loginForm.jsp">로그인</a></li>
        <li><a href="./pds/pdsList.jsp">포토갤러리</a></li>
        <li><a href="./mail/mailForm.jsp">메일보내기</a></li>
        <li><a href="./bbs2/bbslist.do">게시판(MVC)</a></li>
        <li><a href="./member2/loginForm.do">로그인(MVC)</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- First Container -->
<div class="container-fluid bg-4 text-center">
	<!-- 디지털시계 -->
    <form name="myform">
      <input type="text" name="clock" size="20" class="time" readonly>
    </form>	
</div>

<div class="container-fluid bg-1 text-center">
  <img src="./images/k1.png" class="img-responsive img-circle margin" style="display:inline" width="200" height="200">
</div>

<!-- Third Container (Grid) -->
<div class="container-fluid bg-3 text-center">    
<img src="./images/k2.png" class="img-responsive img-circle margin" style="display:inline"  width="200" height="200">
  <h3 class="margin">나만의 공간</h3><br>
</div>

<!-- Footer -->
<footer class="container-fluid bg-4 text-center">
  Copyright &copy; 2019 myweb 
</footer>

</body>
</html>
