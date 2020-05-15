<%@page import="ch13.model.BoardDBBean"%>
<%@page import="ch13.model.BoardDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="color.jspf"%>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	request.setCharacterEncoding("UTF-8");

    String pageNum = request.getParameter("pageNum");

    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum); //1, 2
    int startRow = (currentPage - 1) * pageSize + 1; //1, 11
    int endRow = currentPage * pageSize; //10, 20
    int count = 0;
    int number = 0;
    List<BoardDataBean> articleList = null; 
    
    BoardDBBean dbPro = BoardDBBean.getInstance();
    count = dbPro.getArticleCount();
    
    if (count > 0) {
    	/*mysql의 limit (시작하는 인덱스, 몇개씩 읽어라)
    	  articleList = dbPro.getArticles(startRow, pageSize);
    	  oracle은 (시작하는 인덱스, 마지막 인덱스)*/
    	//hbbaek.m for oracle
        articleList = dbPro.getArticles(startRow, endRow);
    }

   number = count-(currentPage-1)*pageSize;
%>
<html>
<head>
<link href="style.css?after" rel="stylesheet" type="text/css">
<title>게시판</title>
</head>
<body bgcolor="<%=bodyback_c%>">
<p>글목록(전체 글:<%=count%>)</p>

<div style="position: relative; width: 624; height: 23; margin-left:auto; margin-right:auto;">
	<table style="position: absolute; left: 0;">
	  <tr>
	    <td align="right" bgcolor="<%=value_c%>">
	       <a href="writeForm.do">글쓰기</a>
	    </td>
	  </tr>
	</table>
</div>

<% if (count == 0) { %>

<table style="margin-left:auto; margin-right:auto;">
<tr height="30" bgcolor="<%=value_c%>">
    <td align="center" width="700">
              게시판에 저장된 글이 없습니다.
    </td>
</table>

<% } else {%>
<table style="margin-left:auto; margin-right:auto;"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td> 
      <!-- hbbaek.m for ip숨기기 -->
      <!-- <td align="center"  width="100" >IP</td> -->    
    </tr>
<%  
   for (int i = 0 ; i < articleList.size() ; i++) {
       BoardDataBean article = articleList.get(i);
%>
   <tr height="30">
    <td  width="50" > <%=number--%></td>
    <td  width="250" align="left">
<%
   int wid=0; 
   if(article.getRe_level()>0){
      wid=5*(article.getRe_level());
%>
     <img src="images/level.png" width="<%=wid%>" height="16">
     <img src="images/re.png">
<%  }else{%>
     <img src="images/level.png" width="<%=wid%>" height="16">
<%  }%>
           
      <a href="content.do?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject()%></a> 
<% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td width="100" align="left"> 
       <a href="mailto:<%=article.getEmail()%>">
                     <%=article.getWriter()%></a></td>
    <td width="150"><%= sdf.format(article.getReg_date())%></td>
    <td width="50"><%=article.getReadcount()%></td>
    <!-- hbbaek.m for ip숨기기 -->
    <%-- <td width="100" ><%=article.getIp()%></td> --%>
  </tr>
<%}%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage =1;
      
      if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
      else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

      int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) { %>
          <a href="list.do?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="list.do?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="list.do?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</body>
</html>