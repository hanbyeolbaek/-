<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER LOGIN</title>
<link href="style.css?after" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<%
String id = (String)session.getAttribute("id");
if(request.getAttribute("checkId") !=null){
	
	int checkId = (int)request.getAttribute("checkId");
	if(checkId == -1){
		%>
		<script>
		alert("해당 아이디를 찾을 수 없습니다.");
		</script>
		<% 
	}
	else if (checkId == 1) {
		%>
		<script>
		alert("아이디와 패스워드가 일치하지 않습니다.");
		</script>
		<%
	}
}
%>   
	<form name="login" action="loginPro.do" method="post">
		<table border=1 style="margin-left:auto; margin-right:auto;">
			<tr>
				<td colspan="2" align="center"><b><font size=5>LOGIN</font></b></td>
			</tr>
			<tr align="center">
				<td>아이디 :</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr align="center">
				<td>비밀번호 :</td>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2"  align="center">
					<input type="submit" value="login">
					<input type="button" onclick="location.href='joinForm.do'" value="sign up">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


