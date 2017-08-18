package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.SurveyUtil;

/**
 * Servlet implementation class UpdateAccreditor
 */
@WebServlet("/UpdateAccreditor")
public class UpdateAccreditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccreditor() {
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
		int changeID = Integer.parseInt(request.getParameter("accID"));
		SurveyUtil surUtil = new SurveyUtil();
		surUtil.updateAccreditor(accreditorID, PSID, areaID, changeID);
		response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
	    response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
	    response.getWriter().write("nice"); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
