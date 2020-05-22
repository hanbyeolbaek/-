<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<%
	String pageNum = (String)request.getAttribute("pageNum");
	String mId = (String)request.getAttribute("mId");
	int deleteId = (int)request.getAttribute("deleteId");
	if(deleteId==1){
%>
		<script type="text/javascript">      
         	alert("회원탈퇴가 정상적으로 완료되었습니다. 안녕히가세요.");
         	location.href='index.jsp';
   		</script>
<%
	}else if(deleteId==0){
%>
		<script type="text/javascript">      
         	alert('<%=mId%>'+"님을 탈퇴시켰습니다.");
         	location.href='list.du?pageNum=<%=pageNum%>';
   		</script>
<%
	}
%>