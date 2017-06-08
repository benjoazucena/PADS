package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Institution;
import Models.SchoolSystem;
import Utilities.InstitutionUtil;
import Utilities.SchoolSystemUtil;

/**
 * Servlet implementation class EditSchoolSystem
 */
@WebServlet("/EditSchoolSystem")
public class EditSchoolSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditSchoolSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int systemID = Integer.parseInt((String)request.getParameter("schoolsystemID"));
		SchoolSystemUtil ssUtil = new SchoolSystemUtil();
		SchoolSystem ss = ssUtil.getSchoolSystem(systemID);
		ss.setSchoolSystemID(systemID);
		request.setAttribute("SchoolSystem", ss);
		RequestDispatcher rd = request.getRequestDispatcher("editSchoolSystem.jsp");
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
