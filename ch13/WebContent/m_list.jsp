<%@page import="ch13.model.MemberDBBean"%>
<%@page import="ch13.model.MemberDataBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	int count=0;
	int number=0;
	List<MemberDataBean> artList = null;
	
	MemberDBBean dbPro = MemberDBBean.getInstance();
	count = dbPro.listCount();
	
	if(count>0){
		artList = dbPro.listId(startRow, endRow);
	}
	
	number = count-(currentPage-1)*pageSize;
%>

<!DOCTYPE html>
<html>
<head>
<link href="style.css?after" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>게시판</title>
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
</head>
<body bgcolor="<%=bodyback_c%>">
	<%@include file ="nav.jsp" %>
	<p>회원목록(전체 회원 수:<%=count%>)</p>
	<% if(count==0){ %>
	<table border=1 style="margin-left: auto; margin-right: auto;">
		<tr>
			<td align="center" width="700">
				등록된 회원이 없습니다.
			</td>
		</tr>
	</table>
	<% }else{ %>
	<table border=1 style="margin-left:auto; margin-right:auto;">
		<tr>
			<td align="center">번     호</td>
			<td align="center">아 이 디</td>
			<td align="center">비밀번호</td>
			<td align="center">생년월일</td>
			<td align="center">이 메 일</td>
			<td align="center">주     소</td>
			<td align="center">전화번호</td>
			<td align="center">이      름</td>
			<td align="center">가입일자</td>
			<td align="center">삭       제</td>
		</tr>
		<%
			for(int i=0; i<artList.size(); i++){
				MemberDataBean art = artList.get(i);
		%>
		<tr>
			<td><%=number-- %></td>
			<td align="center"><%=art.getId() %></td>
			<td align="center"><%=art.getPasswd() %></td>
			<td align="center"><%=art.getDate_number() %></td>
			<td align="center"><%=art.getEmail()%></td>
			<td align="center"><%=art.getAddress() %></td>
			<td align="center"><%=art.getTel() %></td>
			<td align="center"><%=art.getName() %></td>
			<td align="center"><%=sdf.format(art.getReg_date()) %></td>
			<td align="center">
				<input type="button" onclick="location.href='deletePro.du?id=<%=art.getId() %>&pageNum=<%=pageNum %>'" value="삭제">
			</td>
		</tr>
		<%	} %>
	</table>
	<%
		}
		if(count>0){
			int pageCount = count/pageSize+(count%pageSize==0?0:1);
			int startPage=1;
			
			if(currentPage%10!=0)
				startPage=(int)(currentPage/10)*10+1;
			else
				startPage=((int)(currentPage/10)-1)*10+1;
			
			int pageBlock=10;
			int endPage=startPage+pageBlock-1;
			
			if(endPage>pageCount)
				endPage=pageCount;
			
			if(startPage>10){
	%>
				<a href="list.du?pageNum=<%=startPage-10 %>">[이전]</a>
	<%
			}
			
			for(int i=startPage; i<=endPage; i++){
	%>
				<a href="list.du?pageNum=<%=i %>">[<%=i %>]</a>
	<%
			}
			
			if(endPage<pageCount){
	%>
				<a href="list.du?pageNum=<%=startPage+10 %>">[다음]</a>
	<%
			}
		}
	%>
</body>
</html>

