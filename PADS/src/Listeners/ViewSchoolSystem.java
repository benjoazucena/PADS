package Listeners;

import java.io.IOException;
import java.util.ArrayList;

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
 * Servlet implementation class ViewSchoolSystem
 */
@WebServlet("/ViewSchoolSystem")
public class ViewSchoolSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewSchoolSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int systemID = Integer.parseInt(request.getParameter("schoolsystemID"));
		System.out.println("View Institution: " + systemID);
		SchoolSystemUtil ssUtil = new SchoolSystemUtil();
		SchoolSystem ss = ssUtil.getSchoolSystem(systemID);
		InstitutionUtil instUtil = new InstitutionUtil();
		ArrayList<Institution> inst = instUtil.getSchoolSystemInstitutions(systemID);
		request.setAttribute("schoolsystem", ss);
		request.setAttribute("institutions", inst);
		
		RequestDispatcher rd = request.getRequestDispatcher("schoolSystemProfile.jsp");
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
