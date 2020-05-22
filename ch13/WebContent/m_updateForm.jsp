<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>

<% String id = (String)session.getAttribute("id"); %>

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
	<form name="updateform" method="post" action="updatePro.du">
		<table border=1 style="margin-left:auto; margin-right:auto;">
			<tr>
				<td colspan="2" align="center"><b><font size=5><%=id %>님의 정보수정</font></b></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="date" name="date_num"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="tel" name="tel"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="정보수정">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>