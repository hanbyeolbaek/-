package ch13.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

public class BoardDBBean {
   private static BoardDBBean instance = new BoardDBBean();
   public static BoardDBBean getInstance() {
      return instance;
   }
   private BoardDBBean() {
      
   }
   
   private Connection getConnection() throws Exception {
      Context initCtx = new InitialContext();
      Context envCtx = (Context)initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource)envCtx.lookup("jdbc/oracledb");
//      System.out.println("연결하까마까");
      return ds.getConnection();
   }
   
   private void closeDBResources(ResultSet rs, Statement stmt, Connection conn) {
      if(rs != null) {
         try {
            rs.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(stmt != null) {
         try {
         stmt.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
         conn.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }
   private void closeDBResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
      if(rs != null) {
         try {
            rs.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(pstmt != null) {
         try {
         pstmt.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
         conn.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }
   private void closeDBResources(PreparedStatement pstmt, Connection conn) {
      if(pstmt != null) {
         try {
         pstmt.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
         conn.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }
   private void closeDBResources(Statement stmt, Connection conn) {
      if(stmt != null) {
         try {
         stmt.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
         conn.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }
   private void closeDBResources(ResultSet rs, PreparedStatement pstmt) {
      if(rs != null) {
         try {
            rs.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      if(pstmt != null) {
         try {
         pstmt.close();
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
   }
   
   //boarde 테이블에 글을 추가(insert문) <=writePro.jsp 페이지에서 사용
   public void insertArticle(BoardDataBean article) throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int num = article.getNum();
      int ref = article.getRef();
      int re_step = article.getRe_step();
      int re_level = article.getRe_level();
      int number = 0;
      String sql = "";
      
      try {
         conn = getConnection();
         if(conn==null) {
            System.out.println("fail");
         }else {
            System.out.println("connection");
         }
         sql = "select max(num) from boarde";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            number = rs.getInt(1) + 1;
         }else {
            number = 1;
         }
         
         closeDBResources(rs, pstmt);
         
         //num 기준으로 댓글과 원본글 구분짓기
         if(num!=0) { //댓글쓰기
            sql = "update boarde set re_step = re_step + 1 where ref = ? and re_step > ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ref);
            pstmt.setInt(2, re_step);
            pstmt.executeUpdate();
            re_step = re_step + 1;
            re_level = re_level + 1;
         }else { //원본글쓰기
            ref = number;
            re_step = 0;
            re_level = 0;
         }
         closeDBResources(rs, pstmt);
         //hbbaek.m for add filename
         sql = "insert into boarde (num, writer, email, subject, passwd, reg_date, ";
         sql += "ref, re_step, re_level, content, ip, filename) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, number);
            pstmt.setString(2, article.getWriter());
            pstmt.setString(3, article.getEmail());
            pstmt.setString(4, article.getSubject());
            pstmt.setString(5, article.getPasswd());
			pstmt.setTimestamp(6, article.getReg_date());
            pstmt.setInt(7, ref);
            pstmt.setInt(8, re_step);
            pstmt.setInt(9, re_level);
         pstmt.setString(10, article.getContent());
         pstmt.setString(11, article.getIp());
       //hbbaek.m for add filename
         pstmt.setString(12, article.getFileName());
         pstmt.executeUpdate();
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
   }
   
   //boarde 테이블에 저장된 전체 글의 수를 얻어냄(select문) <=list.jsp에서 사용
   public int getArticleCount() {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int x = 0;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select count(*) from boarde");
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            x = rs.getInt(1);
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return x;
   }
   
   //글의 목록(복수 개의 글)을 가져옴(select문) <=list.jsp에서 사용
   public List<BoardDataBean> getArticles(int start, int end) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      List<BoardDataBean> articleList = null;
      
      try {
         conn = getConnection();
         
         //BoardDAO - boardList 메서드 페이징 처리
         //pstmt = conn.prepareStatement("select * from boarde order by ref desc, re_step asc limit ?,?"); //mysql
         String sql = "SELECT * "
        		 + "FROM (SELECT ROWNUM rnum, B.* FROM "
        		 + " (SELECT * FROM boarde ORDER BY ref desc, re_step asc ) B ) ";
         sql += " WHERE rnum >= ? and rnum <= ?";
         //rnum 생성하자마자 조건 체크가 안되기 때문에 위와 같이
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            articleList = new ArrayList<BoardDataBean>(end);
            do {
               BoardDataBean article = new BoardDataBean();
               article.setNum(rs.getInt("num"));
               article.setWriter(rs.getString("writer"));
               article.setEmail(rs.getString("email"));
               article.setSubject(rs.getString("subject"));
               article.setPasswd(rs.getString("passwd"));
               article.setReg_date(rs.getTimestamp("reg_date"));
               article.setReadcount(rs.getInt("readcount"));
               article.setRef(rs.getInt("ref"));
               article.setRe_step(rs.getInt("re_step"));
               article.setRe_level(rs.getInt("re_level"));
               article.setContent(rs.getString("content"));
               article.setIp(rs.getString("ip"));
               
               articleList.add(article);
            }while(rs.next());
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return articleList;
   }
   
   //글의 내용을 보기(1개의 글)(select문) <=content.jsp 페이지에서 사용
   public BoardDataBean getArticle(int num) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      BoardDataBean article = null;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("update boarde set readcount = readcount + 1 where num = ?");
         pstmt.setInt(1, num);
         pstmt.executeUpdate();
         
         pstmt = conn.prepareStatement("select * from boarde where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            article = new BoardDataBean();
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setEmail(rs.getString("email"));
            article.setSubject(rs.getString("subject"));
            article.setPasswd(rs.getString("passwd"));
            article.setReg_date(rs.getTimestamp("reg_date"));
            article.setReadcount(rs.getInt("readcount"));
            article.setRef(rs.getInt("ref"));
            article.setRe_step(rs.getInt("re_step"));
            article.setRe_level(rs.getInt("re_level"));
            article.setContent(rs.getString("content"));
            article.setIp(rs.getString("ip"));
            article.setFileName(rs.getString("filename"));
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return article;
   }
   
   //글수정 폼에서 사용할 글의 내용(1개의 글)(select문) <=updateForm.jsp에서 사용
   public BoardDataBean updateGetArticle(int num) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      BoardDataBean article = null;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select * from boarde where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            article = new BoardDataBean();
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setEmail(rs.getString("email"));
            article.setSubject(rs.getString("subject"));
            article.setPasswd(rs.getString("passwd"));
            article.setReg_date(rs.getTimestamp("reg_date"));
            article.setReadcount(rs.getInt("readcount"));
            article.setRef(rs.getInt("ref"));
            article.setRe_step(rs.getInt("re_step"));
            article.setRe_level(rs.getInt("re_level"));
            article.setContent(rs.getString("content"));
            article.setIp(rs.getString("ip"));
            article.setFileName(rs.getString("filename"));
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return article;
   }
   
   //글수정 처리에서 사용(update문) <=updatePro.jsp에서 사용
   public int updateArticle(BoardDataBean article) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbpasswd = "";
      String sql = "";
      int x = -1;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select passwd from boarde where num = ?");
         pstmt.setInt(1, article.getNum());
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dbpasswd = rs.getString("passwd");
            if(dbpasswd.equals(article.getPasswd())) {
               sql = "update boarde set writer = ?, email = ?, subject = ?, passwd = ?, "
               		+ " content = ? where num = ?";
               pstmt = conn.prepareStatement(sql);
               
               pstmt.setString(1, article.getWriter());
               pstmt.setString(2, article.getEmail());
               pstmt.setString(3, article.getSubject());
               pstmt.setString(4, article.getPasswd());
               pstmt.setString(5, article.getContent());
               pstmt.setInt(6, article.getNum());
               pstmt.executeUpdate();
               
               x = 1;
            }else {
               x = 0;
            }
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return x;
   }
   
   //글삭제처리시 사용(delete문) <=deletePro.jsp 페이지에서 사용
   public int deleteArticle(int num, String passwd) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbpasswd = "";
      int x = -1;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select passwd from boarde where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dbpasswd = rs.getString("passwd");
            if(dbpasswd.equals(passwd) || passwd.equals("admin")) {
               pstmt = conn.prepareStatement("delete from boarde where num = ?");
               pstmt.setInt(1, num);
               pstmt.executeUpdate();
               x = 1;
            }else {
               x = 0;
            }
         }
      }catch (Exception ex) {
         ex.printStackTrace();
      }finally {
         closeDBResources(rs, pstmt, conn);
      }
      return x;
   }
   
	//hbbaek.a for 회원정보 바꼈을경우 게시글 정보도 변경
	public void ChangeBoard(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql ="";
		
		try {
			conn = getConnection();
			
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "update boarde set email=?, passwd=? where writer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString("email"));
				pstmt.setString(2, rs.getString("passwd"));
				pstmt.setString(3, rs.getString("id"));
				pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDBResources(rs, pstmt, conn);
		}
	}
}
