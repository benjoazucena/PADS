package Listeners;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Accreditation;
import Models.Accreditor;
import Utilities.AccreditorUtil;

/**
 * Servlet implementation class ViewAccreditor
 */
@WebServlet("/ViewAccreditor")
public class ViewAccreditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewAccreditor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int accreditorID = Integer.parseInt(request.getParameter("accreditorID"));
		System.out.println("View Accreditor: " + accreditorID);
		AccreditorUtil accUtil = new AccreditorUtil();
		//accUtil.deleteAccreditor(accreditorID);
		Accreditor acc = accUtil.getAccreditor(accreditorID);
		request.setAttribute("accreditor", acc);
		ArrayList<Accreditation> past = accUtil.getAccreditations(accreditorID);
		request.setAttribute("accreditations", past);
		RequestDispatcher rd = request.getRequestDispatcher("accreditorProfile.jsp");
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
