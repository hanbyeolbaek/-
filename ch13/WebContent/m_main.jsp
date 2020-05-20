<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*"%>

<%
	String name = "";
	if (session.getAttribute("name") != null){
		name = (String)session.getAttribute("name");
	}else{
%>
<!-- 아랫단 실행하지 않고 값을 못받아왔을때 로그인 화면으로 넘어감 -->
<jsp:forward page="loginForm.jsp" />
<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER MAIN</title>
</head>
<body>
	<h3 align=center>
		<%=name %>님, 어서오시게!!
	</h3>

<%
	if (name.equals("관리자")) {
%>
	<table style="margin-left:auto; margin-right:auto;">
		<tr align="center">
			<td>
				<input type="button" onclick="location.href='member_list.jsp'" value="member list">
			</td>
		</tr>
	</table>
<%
	}else{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String jdbc_driver = "oracle.jdbc.OracleDriver";
			String db_url  = "jdbc:oracle:thin:@localhost:1521:XE";
			
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(db_url, "scott", "tiger");
			
			String sql = "select * from member where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			rs.next();
%>
	<table border=1 width=300 style="margin-left:auto; margin-right:auto;">
		<tr align=center>
			<td>EMAIL:</td>
			<td><%=rs.getString("email")%></td>
		</tr>
		<tr align=center>
			<td>NAME:</td>
			<td><%=rs.getString("name")%></td>
		</tr>
		<tr align=center>
			<td>DATE:</td>
			<td><%=rs.getString("time")%></td>
		</tr>
		<tr align=center>
			<td colspan=2>
				<input type="button" onclick="location.href='updateForm.jsp'" value="UPDATE">
				<input type="button" onclick="location.href='loginForm.jsp'" value="LOGOUT">
			</td>
		</tr>
	</table>
<%
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null)
				try{rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)
				try{conn.close();}catch(SQLException sqle){}
		}
	}
%>
</body>
</html>