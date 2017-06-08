package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.AccreditorUtil;

/**
 * Servlet implementation class UpdateConfirmation
 */
@WebServlet("/UpdateConfirmation")
public class UpdateConfirmation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateConfirmation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int accreditorID = Integer.parseInt(request.getParameter("accreditorID"));
		int PSID = Integer.parseInt(request.getParameter("PSID"));
		int areaID = Integer.parseInt(request.getParameter("areaID"));
		String confirmation = request.getParameter("confirmation");
		AccreditorUtil accUtil = new AccreditorUtil();
		String text = accUtil.updateConfirmation(accreditorID, confirmation, PSID, areaID);
		response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
	    response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
	    response.getWriter().write(text); 
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
