package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.AccreditorUtil;
import Utilities.InstitutionUtil;
import Utilities.SurveyUtil;

/**
 * Servlet implementation class ConfirmAttendance
 */
@WebServlet("/ConfirmAttendance")
public class ConfirmAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmAttendance() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int accID = Integer.parseInt(request.getParameter("accID"));
		int areaID = Integer.parseInt(request.getParameter("areaID"));
		int PSID = Integer.parseInt(request.getParameter("PSID"));
		int add = Integer.parseInt(request.getParameter("add"));
		SurveyUtil sUtil = new SurveyUtil();
		sUtil.confirmAttendance(PSID, areaID, accID);
		
		AccreditorUtil aUtil = new AccreditorUtil();
		aUtil.updateTotalSurveys(accID, add);

		RequestDispatcher rd = request.getRequestDispatcher("Institutions");
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
