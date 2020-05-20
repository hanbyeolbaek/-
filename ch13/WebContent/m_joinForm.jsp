<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER SIGN UP</title>
<link href="style.css?after" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<form name="joinform" action="joinPro.do" method="post">
		<table border=1 style="margin-left:auto; margin-right:auto;">
			<tr>
				<td colspan="2" align="center"><b><font size=5>SIGN UP</font></b></td>
			</tr>
			<tr align="center">
				<td>아이디 :</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr align="center">
				<td>비밀번호 :</td>
				<td><input type="password" name="passwd"></td>
			</tr>
			<!-- 추후 javascript로 비밀번호 일치 체크 기능 삽입 -->
			<tr align="center">
				<td>생년월일 :</td>
				<td><input type="date" name="date_num"></td>
			</tr>
			<tr align="center">
				<td>이메일 :</td>
				<td><input type="email" name="email"></td>
			</tr>
			<tr align="center">
				<td>주소 :</td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr align="center">
				<td>전화번호 :</td>
				<td><input type="tel" name="tel"></td>
			</tr>
			<tr align="center">
				<td>이름 :</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td colspan="2"  align="center">
					<input type="submit" value="sign up">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>