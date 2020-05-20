<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.sql.*" %>

<%
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		String jdbc_driver = "oracle.jdbc.OracleDriver";
		String db_url  = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(db_url, "scott", "tiger");
		
		String sql = "select * from member where email = ? and pwd = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, pwd);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			String rEmail = rs.getString("email");
			String rPwd = rs.getString("pwd");
			if(email.equals(rEmail) && pwd.equals(rPwd)){
				sql = "update member set name = ? where email = ? and pwd = ?";
				if(rs!=null)
					try{rs.close();}catch(SQLException sqle){}
				if(pstmt!=null)
					try{pstmt.close();}catch(SQLException sqle){}
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				pstmt.setString(3, pwd);
				pstmt.executeUpdate();
				name = "";
				if(rs.next()){
					name = rs.getString("name");
					session.setAttribute("name", name);
					response.sendRedirect("main.jsp");
				}
			}else{
				response.sendRedirect("loginForm.jsp");
			}
		}else{
			response.sendRedirect("loginForm.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs!=null)
			try{rs.close();}catch(SQLException sqle){sqle.printStackTrace();}
		if(pstmt!=null)
			try{pstmt.close();}catch(SQLException sqle){sqle.printStackTrace();}
		if(conn!=null)
			try{conn.close();}catch(SQLException sqle){sqle.printStackTrace();}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>