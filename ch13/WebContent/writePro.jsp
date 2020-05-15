<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="ch13.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!-- 
scope="page"는 앞전 페이지의 값들을 받아와서 사용하겠다.
jsp:useBean은 파라메타값이 넣었던 값 그대로 뱉어내게됨.(int로 넣으면 int로 나옴)
request.getParameter는 무조건 string으로 나옴
 -->

<%
	response.sendRedirect("list.do");
%>