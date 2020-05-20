<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="updateform" method="post" action="updateProcess.jsp">
		<table border=1 style="margin-left:auto; margin-right:auto;">
			<tr>
				<td colspan="2" align="center"><b><font size=5>UPDATE</font></b></td>
			</tr>
			<tr>
				<td>EMAIL :</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>PASSWORD :</td>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<td>CHANGE NAME :</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="UPDATE">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>