<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList.*" %>

<%@ page import="net.utility.*" %>
<%@ page import="net.notice.*" %>


<jsp:useBean id="dao" class="net.notice.NoticeDAO"></jsp:useBean>
<jsp:useBean id="dto" class="net.notice.NoticeDTO"></jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>


<%
//검색 목록 페이지
String col = request.getParameter("col");
String word = request.getParameter("word");

col= Utility.checkNull(col);
word = Utility.checkNull(word);


//현재 페이지
int nowPage = 1;
if(request.getParameter("nowPage") != null){
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
}



%>
