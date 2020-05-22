<%@page import="ch13.model.BoardDataBean"%>
<%@page import="ch13.model.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>
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
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
	<!-- hbbaek.a for nav -->
	<%@include file ="nav.jsp" %>
<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try{
      BoardDBBean dbPro = BoardDBBean.getInstance(); 
      BoardDataBean article =  dbPro.updateGetArticle(num);
%>

<p>글수정</p>
<br>
<form method="post" name="writeform" 
action="updatePro.do?pageNum=<%=pageNum%>" onsubmit="return writeSave()" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table style="margin-left:auto; margin-right:auto;">
  	<tr>
    	<td  width="70"  bgcolor="<%=value_c%>" align="center" >제 목</td>
    	<td align="left" width="330">
       		<input type="text" size="40" maxlength="50" name="subject"
        	value="<%=article.getSubject()%>" style="ime-mode:active;"></td>
  	</tr>
  	<tr>
    	<td  width="70"  bgcolor="<%=value_c%>" align="center" >내 용</td>
    	<td align="left" width="330">
     	<textarea name="content" rows="13" cols="40" 
       	style="ime-mode:active;"><%=article.getContent()%></textarea></td>
  	</tr>
  	<!-- hbbaek.a for file upload -->
	<tr>
		<td width="70" bgcolor="<%=value_c%>" align="center">파일선택</td>
		<td width="330" align="left">
			<%
			String filename = article.getFileName();
			if(filename!=null && !filename.equals("")) { 
			%>
			<%=filename %>
			<% } else { %>
				파일이 없습니다.
			<% } %>
			<input type="file" name="selectfile">
		</td>
	</tr>
  	<tr>
    	<td  width="70"  bgcolor="<%=value_c%>" align="center" >비밀번호</td>
    	<td align="left" width="330" >
     		<input type="password" size="8" maxlength="12" 
			name="passwd" style="ime-mode:inactive;">
	 	</td>
  	</tr>
  	<tr>      
   		<td colspan=2 bgcolor="<%=value_c%>" align="center"> 
     		<input type="submit" value="글수정" >  
     		<input type="reset" value="다시작성">
     		<input type="button" value="목록보기" 
       		onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
   		</td>
 	</tr>
 </table>
</form>
<%
}catch(Exception e){e.printStackTrace();}%>      
      
</body>
</html>