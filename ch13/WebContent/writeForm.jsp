<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="color.jspf"%>
<%! //정의부, 선언부
	//함수
	//전역변수
%>

<% 
  int num = 0, ref = 1, re_step = 0, re_level = 0;
  String strV = "";
  try{
    if(request.getParameter("num")!=null){
	   num=Integer.parseInt(request.getParameter("num"));
	   ref=Integer.parseInt(request.getParameter("ref"));
	   re_step=Integer.parseInt(request.getParameter("re_step"));
	   re_level=Integer.parseInt(request.getParameter("re_level"));
    }
 /*
 WritePro.jsp에서 jsp:useBean으로 자료를 넘기게되면 중간과정 거치지 않고 바로 BoardDBBean.java로
 넘어가기 때문에 사전에 확인할 수 있도록 WriteForm.jsp에서 위와같이 null 체크해주는 코드가 필요함
 */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css?after" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%=bodyback_c %>">
	<p>글쓰기</p>

	<form method="post" action="writePro.do" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<table style="margin-left:auto; margin-right:auto;">
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c%>">
					<a href="#"> 글목록</a>
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이 름</td>
				<td width="330" align="left">
					<input type="text" size="10" maxlength="10" name="writer" style="ime-mode: active;">
					<!--active:한글-->
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제 목</td>
				<td width="330" align="left">
					<input type="text" size="40" maxlength="50" name="subject" value="<%=strV%>" style="ime-mode: active;">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
				<td width="330" align="left">
					<input type="text" size="40" maxlength="30" name="email" style="ime-mode: inactive;">
				</td>
				<!--inactive:영문-->
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">내 용</td>
				<td width="330" align="left">
					<textarea name="content" rows="13" cols="40" style="ime-mode: active;"></textarea>
				</td>
			</tr>
			<!-- hbbaek.a for file upload -->
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">파일선택</td>
				<td width="330" align="left">
					<input type="file" name="selectfile">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left">
					<input type="password" size="8" maxlength="12" name="passwd" style="ime-mode: inactive;">
				</td>
			</tr>
			<tr>
				<td colspan=2 bgcolor="<%=value_c%>" align="center">
					<input type="submit" value="글쓰기">
					<input type="reset" value="다시작성">
					<input type="button" value="목록보기" OnClick="window.location='list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<%
  }catch(Exception e){
	  e.printStackTrace();
  }
%> 