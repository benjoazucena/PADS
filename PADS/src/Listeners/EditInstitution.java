package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Institution;
import Models.Program;
import Utilities.InstitutionUtil;
import Utilities.ProgramUtil;

/**
 * Servlet implementation class EditInstitution
 */		
@WebServlet("/EditInstitution")
public class EditInstitution extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditInstitution() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int institutionID = Integer.parseInt(request.getParameter("institutionID"));
		InstitutionUtil instUtil = new InstitutionUtil();
		Institution inst = instUtil.getInstitution(institutionID);
		inst.setInstitutionID(institutionID);
		request.setAttribute("institution", inst);
		
		RequestDispatcher rd = request.getRequestDispatcher("editInstitution.jsp");
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
