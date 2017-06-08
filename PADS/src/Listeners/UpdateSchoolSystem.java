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
 * Servlet implementation class UpdateSchoolSystem
 */
@WebServlet("/UpdateSchoolSystem")
public class UpdateSchoolSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSchoolSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String SchoolSystemName = request.getParameter("ssName");
		String date_joined = request.getParameter("joinDate");
		int systemID = Integer.parseInt(request.getParameter("systemID"));
		SchoolSystemUtil ssUtil = new SchoolSystemUtil();
		ssUtil.editSchoolSystem(systemID, SchoolSystemName, date_joined);	
		System.out.println("output1:"+ SchoolSystemName);
		RequestDispatcher rd = request.getRequestDispatcher("SchoolSystems");
		rd.forward(request, response);
	}

}
