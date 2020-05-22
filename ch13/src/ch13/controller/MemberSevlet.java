package ch13.controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch13.model.BoardDBBean;
import ch13.model.MemberDBBean;
import ch13.model.MemberDataBean;

/**
 * Servlet implementation class MemberSevlet
 */
@WebServlet("*.du")
public class MemberSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSevlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		//PrintWriter out = response.getWriter();
		String uri = request.getRequestURI();
		System.out.println("############ hbbaek uri : "+uri);
		int lastIndex = uri.lastIndexOf("/");
		String action = uri.substring(lastIndex+1);
		System.out.println("############ hbbaek action : "+action);
		String viewPage = null;
		
		//hbbaek.a for login
				if(action.equals("login.du")) {
					viewPage = "m_login.jsp";
				}
			
				if(action.contentEquals("loginPro.du")) {
						String id = request.getParameter("id");
						String passwd = request.getParameter("passwd");
						response.setContentType("text/html;charset=UTF-8");
						try {
							MemberDBBean dbPro = MemberDBBean.getInstance();
							String pwd = dbPro.checkIdPw(id);
							if (pwd == null) {
								// id를 찾을 수 없음
								request.setAttribute("checkId", -1);
								viewPage = "m_login.jsp";
							} else if (passwd.equals(pwd)) {
								//id, passwd 동일, 로그인 성공
								request.setAttribute("checkId", 0);
								request.getSession().setAttribute("id", id);
								viewPage = "list.jsp";
							} else {
								//passwd가 틀림
								request.setAttribute("checkId", 1);
								viewPage = "m_login.jsp";
								/*
								 * out.print("<script type=text/javascript>");
								 * out.print("alert('아이디와 패스워드가 일치하지 않습니다."); out.print("history.back()");
								 * out.print("</script>");
								 */
							}
						}catch (Exception e) {
							e.printStackTrace();
						}
				}
				
				if(action.equals("joinForm.du")) {
					viewPage = "m_joinForm.jsp";
				}
				
				if(action.equals("joinPro.du")) {
					int check = 0;
					try {
						MemberDataBean art = new MemberDataBean();
						
						art.setId(request.getParameter("id"));
						art.setPasswd(request.getParameter("passwd"));
						art.setDate_number(request.getParameter("date_num"));
						art.setEmail(request.getParameter("email"));
						art.setAddress(request.getParameter("address"));
						art.setTel(request.getParameter("tel"));
						art.setName(request.getParameter("name"));
						art.setReg_date(new Timestamp(System.currentTimeMillis()));

						MemberDBBean dbPro = MemberDBBean.getInstance();
						check = dbPro.joinIdPw(art);
					}catch (Exception e) {
						e.printStackTrace();
					}
					request.setAttribute("check", check);
					viewPage = "m_joinPro.jsp";
				}
				
				if(action.equals("main.du")) {
					String id = (String)request.getSession().getAttribute("id");
					try {
						
						MemberDBBean dbPro = MemberDBBean.getInstance();
						MemberDataBean art = dbPro.MainIdPw(id);
						request.setAttribute("vo", art);
					}catch (Exception e) {
						e.printStackTrace();
					}
					viewPage = "m_main.jsp";
				}
				
				if(action.equals("checkPwd.du")) {
					viewPage = "m_checkPwdForm.jsp";
				}
				
				if(action.equals("checkPwdPro.du")) {
					String id = (String)request.getSession().getAttribute("id");
					String passwd = request.getParameter("passwd");
					int check = Integer.parseInt(request.getParameter("check"));
					response.setContentType("text/html;charset=UTF-8");
					try {
						MemberDBBean dbPro = MemberDBBean.getInstance();
						String pwd = dbPro.checkIdPw(id);
						MemberDataBean art = dbPro.MainIdPw(id);
						if (passwd.equals(pwd)) {
							if(check==0) {
								request.setAttribute("checkId", 0);
							}else {
								request.setAttribute("checkId", 2);
							}
						} else {
							request.setAttribute("checkId", 1);
							request.setAttribute("vo", art);
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					viewPage = "m_checkPwdPro.jsp";
				}
				
				if(action.equals("update.du")) {
					viewPage = "m_updateForm.jsp";
				}
				
				if(action.equals("updatePro.du")) {
					String id = (String)request.getSession().getAttribute("id");
					
					try {
						MemberDataBean art = new MemberDataBean();
						
						art.setPasswd(request.getParameter("passwd"));
						art.setDate_number(request.getParameter("date_num"));
						art.setEmail(request.getParameter("email"));
						art.setAddress(request.getParameter("address"));
						art.setTel(request.getParameter("tel"));
						art.setName(request.getParameter("name"));
						
						MemberDBBean dbPro = MemberDBBean.getInstance();
						dbPro.UpdateIdPw(art, id);
						
						BoardDBBean bDbPro = BoardDBBean.getInstance();
						bDbPro.ChangeBoard(id);
					}catch (Exception e) {
						e.printStackTrace();
					}
					viewPage = "m_updatePro.jsp";
				}
				
				if(action.equals("list.du")) {
					viewPage = "m_list.jsp";
				}
				
				if(action.equals("deletePro.du")) {
					String id = (String)request.getSession().getAttribute("id");
					String pageNum = request.getParameter("pageNum");
					try {
						MemberDBBean dbPro = MemberDBBean.getInstance();
						if(id.equals("admin")) {
							String mId = request.getParameter("id");
							dbPro.deleteIdPw(mId);
							request.setAttribute("deleteId", 0);
							request.setAttribute("pageNum", pageNum);
							request.setAttribute("mId", mId);
						}else {
							dbPro.deleteIdPw(id);
							request.setAttribute("deleteId", 1);
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					viewPage = "m_deletePro.jsp";
				}
		
		RequestDispatcher rDis = request.getRequestDispatcher(viewPage);
		rDis.forward(request, response);
	}

}
