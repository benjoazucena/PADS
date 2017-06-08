package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.SchoolSystemUtil;

/**
 * Servlet implementation class AddSchoolSystem
 */
@WebServlet("/AddSchoolSystem")
public class AddSchoolSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddSchoolSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String SchoolSystemName = request.getParameter("ssName");
		String date_joined = request.getParameter("joinDate");
		SchoolSystemUtil ssUtil = new SchoolSystemUtil();
		ssUtil.addSchoolSystem(SchoolSystemName, date_joined);	
		System.out.println("output1:"+ SchoolSystemName);
		RequestDispatcher rd = request.getRequestDispatcher("SchoolSystems");
		rd.forward(request, response);
	}

}
