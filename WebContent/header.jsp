<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="./member/auth.jsp" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Theme Made By www.w3schools.com - No Copyright -->
  <title>My Web</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="../css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/myhome.css?ver=1.2">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="../js/jquery-3.3.1.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/myscript.js?ver=1"></script>
  <style>
  </style>
</head>
<body>

<!-- 메인카테고리 -->
<nav class="navba navbar-default">
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
        <li><a href="../bbs/bbsList.jsp">자유게시판</a></li>
        <li><a href="../notice/noticeList.jsp">공지사항</a></li>
        <li><a href="../member/loginForm.jsp">로그인</a></li>
        <li><a href="../pds/pdsList.jsp">포토갤러리</a></li>
        <li><a href="../mail/mailForm.jsp">메일보내기</a></li>
        <li><a href="../bbs2/bbslist.do">게시판(MVC)</a></li>
        <li><a href="../member2/loginForm.do">로그인(MVC)</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container-fluid bg-3 text-center"></div>
<div class="row"></div>
<div class="col-sm-12"></div>
