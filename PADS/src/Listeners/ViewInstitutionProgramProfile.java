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
import Models.ProgramSurvey;
import Utilities.InstitutionUtil;
import Utilities.ProgramUtil;

/**
 * Servlet implementation class ViewInstitutionProgramProfile
 */	
@WebServlet("/ViewInstitutionProgramProfile")
public class ViewInstitutionProgramProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewInstitutionProgramProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String programName = (String)request.getParameter("programName");
		int SPID = Integer.parseInt((String)request.getParameter("SPID"));
//		System.out.println("View Institution: " + institutionID);
		
		
		
		ProgramUtil progUtil = new ProgramUtil();
		ArrayList<ProgramSurvey> hist = progUtil.getInstitutionProgramSurvey(SPID);
		request.setAttribute("history", hist);
		request.setAttribute("programName", programName);
		RequestDispatcher rd = request.getRequestDispatcher("institutionProgramProfile.jsp");
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
