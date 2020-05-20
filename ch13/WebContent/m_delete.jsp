<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<%
	String delete_email = request.getParameter("email");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String jdbc_driver = "oracle.jdbc.OracleDriver";
		String db_url  = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(db_url, "scott", "tiger");
		
		pstmt = conn.prepareStatement("Delete from member where email = ?");
		pstmt.setString(1, delete_email);
		pstmt.executeUpdate();
		
		response.sendRedirect("member_list.jsp");
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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER DELETE</title>
</head>
<body>
	
</body>
</html>