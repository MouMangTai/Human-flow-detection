package Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.Place;
import Dao.PlaceDao;

/**
 * Servlet implementation class ListPlaceServlet
 */
@WebServlet("/ListPlaceServlet")
public class ListPlaceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListPlaceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Place p = new PlaceDao().get(1);
		response.setHeader("Content-type", "text/html;charset=UTF-8");  
		//这句话的意思，是告诉servlet用UTF-8转码，而不是用默认的ISO8859  
		response.setCharacterEncoding("UTF-8");  
		String str = "{ \"name\" : \""+p.getName()+ "\", \"value\" : \""+p.getNum()+"\"}";  
		//String str = "{\"value\":\""+p.getNum()+"\",\"value\":\""+p.getNum()+"\"}";
		response.getWriter().print(str);
		//request.getRequestDispatcher("main.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
