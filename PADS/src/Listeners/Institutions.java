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
import Utilities.InstitutionUtil;

/**
 * Servlet implementation class Institutions
 */
@WebServlet("/Institutions")
public class Institutions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Institutions() {
        super();
        // TODO Auto-generated constructor stub
    }		

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Institution> inst = new ArrayList<Institution>();
		InstitutionUtil instUtil = new InstitutionUtil();
		inst = instUtil.getInstitutions();
		request.setAttribute("institutions", inst);
		RequestDispatcher rd = request.getRequestDispatcher("institutions.jsp");
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
