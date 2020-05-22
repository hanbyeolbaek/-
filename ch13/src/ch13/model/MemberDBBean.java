package ch13.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
	private static MemberDBBean instance = new MemberDBBean();

	public static MemberDBBean getInstance() {
		return instance;
	}

	private MemberDBBean() {

	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/oracledb");
		return ds.getConnection();
	}

	private void closeDBResources(ResultSet rs, Statement stmt, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void closeDBResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void closeDBResources(PreparedStatement pstmt, Connection conn) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void closeDBResources(Statement stmt, Connection conn) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void closeDBResources(ResultSet rs, PreparedStatement pstmt) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// hbbaek.a for login
	// 로그인 화면에서 사용(select문) <=m_loginPro.jsp에서 사용
	public String checkIdPw(String id) throws Exception {
		String dbpasswd = null; // 초기화를 null로 해주고 컨트롤러에서 null인 경우가 발생할 수 있게끔한다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select passwd from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDBResources(rs, pstmt, conn);
		}
		return dbpasswd;
	}

	// 회원가입 페이지에서 사용(insert문) <=m_joinPro.jsp에서 사용
	public int joinIdPw(MemberDataBean art) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;

		try {
			conn = getConnection();

			sql = "select id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, art.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = 0;
			} else {
				sql = "insert into member(id, passwd, date_number, email, address, tel, name, reg_date) "
						+ " values (?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, art.getId());
				pstmt.setString(2, art.getPasswd());
				pstmt.setString(3, art.getDate_number());
				pstmt.setString(4, art.getEmail());
				pstmt.setString(5, art.getAddress());
				pstmt.setString(6, art.getTel());
				pstmt.setString(7, art.getName());
				pstmt.setTimestamp(8, art.getReg_date());
				pstmt.executeUpdate();
				x = 1;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeDBResources(rs, pstmt, conn);
		}
		return x;
	}

	// 회원정보 화면에서 사용(select문) <=m_main.jsp에서 사용
	public MemberDataBean MainIdPw(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		MemberDataBean art = null;

		try {
			conn = getConnection();

			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				art = new MemberDataBean();
				art.setId(rs.getString("id"));
				art.setPasswd(rs.getString("passwd"));
				art.setDate_number(rs.getString("date_number"));
				art.setEmail(rs.getString("email"));
				art.setAddress(rs.getString("address"));
				art.setTel(rs.getString("tel"));
				art.setName(rs.getString("name"));
				art.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDBResources(rs, pstmt, conn);
		}
		return art;
	}

	// 회원정보수정 페이지에서 사용(update문) <=m_updatePro.jsp에서 사용
	public void UpdateIdPw(MemberDataBean art, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "update member set passwd=?, date_number=?, email=?, address=?, tel=?, name=? where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, art.getPasswd());
			pstmt.setString(2, art.getDate_number());
			pstmt.setString(3, art.getEmail());
			pstmt.setString(4, art.getAddress());
			pstmt.setString(5, art.getTel());
			pstmt.setString(6, art.getName());
			pstmt.setString(7, id);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDBResources(rs, pstmt, conn);
		}
	}
	
	//member 테이블에 정장된 전체 회원의 수를 얻어냄(select문) <=m_list.jsp에서 사용
	public int listCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDBResources(rs, pstmt, conn);
		}
		return x;
	}
	
	//회원의 목록(복수 개의 회원)을 가져옴(select문) <=m_list.jsp에서 사용
	public List<MemberDataBean> listId(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<MemberDataBean> artList = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select * from (select rownum rnum, B.* from (select * from member order by id) B)";
			sql += " where rnum >=? and rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				artList = new ArrayList<MemberDataBean>(end);
				do {
					MemberDataBean art = new MemberDataBean();
					art.setId(rs.getString("id"));
					art.setPasswd(rs.getString("passwd"));
					art.setDate_number(rs.getString("date_number"));
					art.setEmail(rs.getString("email"));
					art.setAddress(rs.getString("address"));
					art.setTel(rs.getString("tel"));
					art.setName(rs.getString("name"));
					art.setReg_date(rs.getTimestamp("reg_date"));
					
					artList.add(art);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDBResources(rs, pstmt, conn);
		}
		return artList;
	}
	
	//회원삭제 처리시 사용(delete문) <=m_deletePro.jsp 페이지에서 사용
	public void deleteIdPw(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "delete from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDBResources(rs, pstmt, conn);
		}
	}
}
