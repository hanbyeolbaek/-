<%@page import="ch13.model.MemberDataBean"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	int checkId = (int)request.getAttribute("checkId");
  	if(checkId==1){
%>
	    <script type="text/javascript">      
         	alert("비밀번호가 맞지 않습니다.");
         	history.go(-1);
   		</script>
<%	}else if(checkId==0){%>
		<meta http-equiv="Refresh" content="0;url=update.du">
<%	}else if(checkId==2){ %>
		<meta http-equiv="Refresh" content="0;url=deletePro.du">
<%	} %>
