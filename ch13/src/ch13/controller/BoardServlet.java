package ch13.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ch13.model.BoardDBBean;
import ch13.model.BoardDataBean;

/**
 * Servlet implementation class BoardServlet
 */
@WebServlet("*.do")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//PrintWriter out = response.getWriter();
		String uri = request.getRequestURI();
		System.out.println("############ hbbaek uri : "+uri);
		int lastIndex = uri.lastIndexOf("/");
		String action = uri.substring(lastIndex+1);
		System.out.println("############ hbbaek action : "+action);
		String viewPage = null;
		
		if(action.equals("writeForm.do")) {
			viewPage = "writeForm.jsp";
		}
		
		if(action.equals("writePro.do")) {
			String realFolder=""; //웹 어플리케이션상의 절대 경로
			String filename = "";
			
			//파일이 업로드되는 폴더 지정
			String saveFolder="/fileSave";
			String encType="utf-8"; //인코딩타입
			int maxSize=5*1024*1024; //최대 업로드될 파일크기 5Mb
			
			
			ServletContext context = getServletContext();
			//현재 jsp페이지의 웹 어플리케이션상의 절대 경로 구함
			realFolder = context.getRealPath(saveFolder);
			MultipartRequest multi = null;
			try {
				// 전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
				// 전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
				multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

				// Form의 파라미터 목록을 가져온다
				// Enumeration<?> params = multi.getParameterNames();

				// 전송한 파일 정보를 가져와 출력한다
				Enumeration<?> files = multi.getFileNames();
				
				//파일 정보 있으면
				while(files.hasMoreElements()){
					//input 태그의 속성이 file인 태그의 name 속성값 : 파라미터이름
					String name = (String)files.nextElement();
					
					//서버에 저장된 파일 이름
					filename = multi.getFilesystemName(name);
				}
				
				BoardDataBean art = new BoardDataBean();
				
				art.setNum(Integer.parseInt(multi.getParameter("num")));
				art.setWriter(multi.getParameter("writer"));
				art.setSubject(multi.getParameter("subject"));
				art.setEmail(multi.getParameter("email"));
				art.setContent(multi.getParameter("content"));
				art.setPasswd(multi.getParameter("passwd"));
				art.setRef(Integer.parseInt(multi.getParameter("ref")));
				art.setRe_step(Integer.parseInt(multi.getParameter("re_step")));
				art.setRe_level(Integer.parseInt(multi.getParameter("re_level")));
				art.setReg_date(new Timestamp(System.currentTimeMillis()));
				art.setIp(request.getRemoteAddr());
				// hbbaek.a for file upload
				art.setFileName(filename);

				BoardDBBean dbPro = BoardDBBean.getInstance();
				dbPro.insertArticle(art);

			}catch(IOException ioe){
			 System.out.println(ioe);
			}catch(Exception ex){
			 System.out.println(ex);
			}

			viewPage = "writePro.jsp";
		}
		
		if(action.equals("list.do")) {
			viewPage = "list.jsp";
		}
		
		if (action.equals("content.do")) {
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			try{
				BoardDBBean dbPro = BoardDBBean.getInstance(); 
				BoardDataBean article =  dbPro.getArticle(num);
				request.setAttribute("vo", article);
		   	} catch(Exception e) {
		   		e.printStackTrace();
		   	}
			request.setAttribute("num", num);
			request.setAttribute("pageNum", pageNum);
			viewPage = "content.jsp";
		}
		
		if(action.equals("updateForm.do")) {
			viewPage = "updateForm.jsp";
		}
		
		if(action.equals("updatePro.do")) {
			String pageNum = request.getParameter("pageNum");
			int check = 0;
			
			String realFolder=""; //웹 어플리케이션상의 절대 경로
			String filename = "";
			
			//파일이 업로드되는 폴더 지정
			String saveFolder="/fileSave";
			String encType="utf-8"; //인코딩타입
			int maxSize=5*1024*1024; //최대 업로드될 파일크기 5Mb
			
			
			ServletContext context = getServletContext();
			//현재 jsp페이지의 웹 어플리케이션상의 절대 경로 구함
			realFolder = context.getRealPath(saveFolder);
			MultipartRequest multi = null;
			try {
				// 전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
				// 전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
				multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

				// Form의 파라미터 목록을 가져온다
				// Enumeration<?> params = multi.getParameterNames();

				// 전송한 파일 정보를 가져와 출력한다
				Enumeration<?> files = multi.getFileNames();
				
				//파일 정보 있으면
				while(files.hasMoreElements()){
					//input 태그의 속성이 file인 태그의 name 속성값 : 파라미터이름
					String name = (String)files.nextElement();
					
					//서버에 저장된 파일 이름
					filename = multi.getFilesystemName(name);
				}
				
				BoardDataBean art = new BoardDataBean();
				
				art.setNum(Integer.parseInt(multi.getParameter("num")));
				art.setWriter(multi.getParameter("writer"));
				art.setSubject(multi.getParameter("subject"));
				art.setEmail(multi.getParameter("email"));
				art.setContent(multi.getParameter("content"));
				art.setPasswd(multi.getParameter("passwd"));
				// hbbaek.a for file upload
				art.setFileName(filename);
				
				BoardDBBean dbPro = BoardDBBean.getInstance();
				check = dbPro.updateArticle(art);
			}catch(IOException ioe){
			 System.out.println(ioe);
			}catch(Exception ex){
			 System.out.println(ex);
			}
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("check", check);
			viewPage = "updatePro.jsp";
		}
		
		if(action.equals("deleteForm.do")) {
			viewPage = "deleteForm.jsp";
		}
		
		if(action.equals("deletePro.do")) {
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			String passwd = request.getParameter("passwd");
			int check = 0;
			
			try {
				BoardDBBean dbPro = BoardDBBean.getInstance(); 
				check = dbPro.deleteArticle(num, passwd);
			}catch (Exception ex) {
				ex.printStackTrace();
			}
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("check", check);
			viewPage = "deletePro.jsp";
		}
		
		RequestDispatcher rDis = request.getRequestDispatcher(viewPage);
		rDis.forward(request, response); //forward : 가지고 온 것들 그대로 전달
	}
}
