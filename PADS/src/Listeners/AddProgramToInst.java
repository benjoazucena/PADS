package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.InstitutionUtil;
import Utilities.SchoolSystemUtil;

/**
 * Servlet implementation class AddProgramToInst
 */
@WebServlet("/AddProgramToInst")
public class AddProgramToInst extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProgramToInst() {
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
		String specific = request.getParameter("specific");
		String level = request.getParameter("level");
		int generalID = Integer.parseInt((String)request.getParameter("general"));
		int instID = Integer.parseInt((String)request.getParameter("instID"));
		
		InstitutionUtil instUtil = new InstitutionUtil();
		instUtil.addProgramToInst(specific, generalID, instID, level);	
	System.out.println("output1:"+ specific);
		RequestDispatcher rd = request.getRequestDispatcher("ViewInstitution?institutionID="+instID);
		rd.forward(request, response);
		doGet(request, response);
	}

}
