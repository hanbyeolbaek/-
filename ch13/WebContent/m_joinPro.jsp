<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER LOGIN PROCESS</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	int check = (int)request.getAttribute("check");
	if(check==1){
%>
		<script type="text/javascript">      
         	alert("회원가입이 성공적으로 완료되었습니다. 로그인해주세요.");
         	history.go(-1);
   		</script>
		<meta http-equiv="Refresh" content="0;url=login.do">
<%
	}else{
%>
		<script type="text/javascript">      
         	alert("이미 존재하는 ID입니다.");
         	history.go(-1);
   		</script>
<%
	}
%>
</body>
</html>