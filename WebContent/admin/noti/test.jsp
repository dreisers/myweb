<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
 
 </HEAD>
 <style>
     #showHide { width:60%; height:60%; background-color:#FFCC00; margin:10px auto; }
 </style>
 
<script>
    function show(){
        document.getElementById("showHide").style.display ='block';
    }
    function hide(){
        document.getElementById("showHide").style.display ='none';
    }
    function showHide(){
        if(document.getElementById("showHide").style.display =='none'){
            document.getElementById("showHide").style.display ='block';
        }
        else{
            document.getElementById("showHide").style.display ='none';
        }
    }
</script>
<body>
     <center>
        
        <input type="checkbox" onclick=showHide();/>
        <button onclick=showHide();>숨기기/보이기</button>
    </center>
    <div id="showHide" align="middle">
        <center>구역</center>
    </div>
 
 </BODY>
</HTML>
