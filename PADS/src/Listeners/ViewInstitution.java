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
import Models.Program;
import Models.SchoolProgram;
import Utilities.InstitutionUtil;
import Utilities.ProgramUtil;

/**
 * Servlet implementation class ViewAccreditor
 */
@WebServlet("/ViewInstitution")
public class ViewInstitution extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewInstitution() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int institutionID = Integer.parseInt(request.getParameter("institutionID"));
		System.out.println("View Institution: " + institutionID);
		InstitutionUtil instUtil = new InstitutionUtil();
		Institution inst = instUtil.getInstitution(institutionID);
		request.setAttribute("institution", inst);
		ProgramUtil progUtil = new ProgramUtil();
		ArrayList<SchoolProgram> progs = progUtil.getInstitutionPrograms(institutionID);
		request.setAttribute("programs", progs);
		
		RequestDispatcher rd = request.getRequestDispatcher("institutionProfile.jsp");
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
