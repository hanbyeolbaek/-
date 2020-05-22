<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ch13.model.MemberDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="color.jspf"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css?after" rel="stylesheet" type="text/css">
	<!-- hbbaek.a for nav style -->
	<style type="text/css">
         /* 기본 설정*/
         a{text-decoration:none; color:#000000;}         
         a:hover{color:#ff0000;}                    
         
         /* nav tag */
         nav ul{padding-top:10px;}
         nav ul li {
            display:inline;
            border-left:1px solid #999;
            font:bold 12px Dotum;
            padding:0 10px;
        }
         nav ul li:first-child{border-left:none;}  
    </style>
</head>
<body bgcolor="<%=bodyback_c%>">
	<!-- hbbaek.a for nav -->
	<%@include file ="nav.jsp" %>

<%
	String id = (String)session.getAttribute("id");
	MemberDataBean art = (MemberDataBean)request.getAttribute("vo");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if (id.equals("admin")) {
%>
	<p>관리자님, 어서오세요.</p>
	<table style="margin-left:auto; margin-right:auto;">
		<tr align="center">
			<td>
				<input type="button" onclick="location.href='list.du'" value="회원목록">
			</td>
		</tr>
	</table>
<%
	}else{
		int check=0;
%>
	<p><%= id %>님의 정보</p>
	<table border=1 width=300 style="margin-left:auto; margin-right:auto;">
		<tr align=center>
			<td>아이디</td>
			<td><%=art.getId()%></td>
		</tr>
		<tr align=center>
			<td>생년월일</td>
			<td><%=art.getDate_number()%></td>
		</tr>
		<tr align=center>
			<td>이메일</td>
			<td><%=art.getEmail()%></td>
		</tr>
		<tr align=center>
			<td>주소</td>
			<td><%=art.getAddress()%></td>
		</tr>
		<tr align=center>
			<td>전화번호</td>
			<td><%=art.getTel()%></td>
		</tr>
		<tr align=center>
			<td>이름</td>
			<td><%=art.getName()%></td>
		</tr>
		<tr align=center>
			<td>가입일자</td>
			<td><%=sdf.format(art.getReg_date())%></td>
		</tr>
		<tr align=center>
			<td colspan=2>
				<input type="button" onclick="location.href='checkPwd.du?check=<%=check %>'" value="정보수정">
				<% check=1; %>
				<input type="button" onclick="location.href='checkPwd.du?check=<%=check %>'" value="회원탈퇴">
			</td>
		</tr>
	</table>
	<%} %>
</body>
</html>