<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String jdbc_driver = "oracle.jdbc.OracleDriver";
		String db_url  = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(db_url, "scott", "tiger");
		
		pstmt = conn.prepareStatement("Select * from member");
		rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border=1 width="300" style="margin-left:auto; margin-right:auto;">
		<tr align=center>
			<td colspan=2>회원목록</td>
		</tr>
<%
			while (rs.next()) {
%>
		<tr align=center>
			<td>
				<a href="member_info.jsp?email=<%=rs.getString("email")%>"> <%=rs.getString("email")%></a>
			</td>
			<td>
				<a href="member_delete.jsp?email=<%=rs.getString("email")%>">삭제</a>
			</td>
		</tr>
<%
			}

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
%>
	</table>
</body>
</html>

