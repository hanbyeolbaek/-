<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="color.jspf"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%
	int check = Integer.parseInt(request.getParameter("check"));
  	String id = (String)session.getAttribute("id");
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<p>비밀번호 확인</p>
	<br>
	<form method="POST" action="checkPwdPro.du?check=<%=check%>"> 
 		<table style="margin-left:auto; margin-right:auto;">
  			<tr height="30">
    			<td align=center>
					<b>비밀번호를 입력해 주세요.</b>
				</td>
  			</tr>
  			<tr height="30">
     			<td align=center >비밀번호 :
       				<input type="password" name="passwd" size="8" maxlength="12">
	   				<input type="hidden" name="id" value="<%= id%>">
	   			</td>
 			</tr>
 			<tr height="30">
    			<td align=center>
      				<input type="submit" value="확인" >
   				</td>
 			</tr>  
		</table> 
	</form>
</body>
</html>