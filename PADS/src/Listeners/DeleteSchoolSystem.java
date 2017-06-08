package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.AccreditorUtil;
import Utilities.SchoolSystemUtil;

/**
 * Servlet implementation class DeleteSchoolSystem
 */
@WebServlet("/DeleteSchoolSystem")
public class DeleteSchoolSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSchoolSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int schoolSystemID = Integer.parseInt(request.getParameter("schoolsystemID"));
		SchoolSystemUtil ssUtil = new SchoolSystemUtil();
		ssUtil.deleteSchoolSystem(schoolSystemID);
		RequestDispatcher rd = request.getRequestDispatcher("SchoolSystems");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
