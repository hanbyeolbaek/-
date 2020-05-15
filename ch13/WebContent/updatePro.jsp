<%@page import="ch13.model.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%-- <jsp:useBean id="article" scope="page" class="ch13.model.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean> --%>
<%
    String pageNum = (String)request.getAttribute("pageNum");
	int check = (int)request.getAttribute("check");

    if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=list.do?pageNum=<%=pageNum%>" >
<% }else{%>
      <script type="text/javascript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
  }
%> 