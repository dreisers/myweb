<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList.*" %>

<%@ page import="net.utility.*" %>
<%@ page import="net.bbs.*" %>


<jsp:useBean id="dao" class="net.bbs.BbsDAO"></jsp:useBean>
<jsp:useBean id="dto" class="net.bbs.BbsDTO"></jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>


<%
//검색 목록 페이지
String col = request.getParameter("col");
String word = request.getParameter("word");

col= Utility.checkNull(col);
word = Utility.checkNull(word);
%>
