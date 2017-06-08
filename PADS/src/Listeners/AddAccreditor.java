package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import Models.Accreditor;
import Utilities.AccreditorUtil;

/**
 * Servlet implementation class AddAccreditor
 */
@WebServlet("/AddAccreditor")
public class AddAccreditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAccreditor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String honorifics = request.getParameter("honorifics");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String middleName = request.getParameter("middleName");
		String email = request.getParameter("email");

		String discipline = request.getParameter("discipline");
		String primaryArea = request.getParameter("primaryArea");
		String secondaryArea = request.getParameter("secondaryArea");
		String tertiaryArea = request.getParameter("tertiaryArea");

		int totalSurveys = 0;
		String city = request.getParameter("city");
		String country = request.getParameter("country");
		String venue_trained = request.getParameter("venue_trained");
		String date_trained = request.getParameter("date_trained");
		String address = request.getParameter("address");
		String contact = request.getParameter("contact");

		
		String obj = request.getParameter("affObject");
		JSONObject jObj = new JSONObject(obj);
		
		
		String institution = "";
		
		Accreditor acc = new Accreditor(0, honorifics, firstName, lastName, middleName, email, contact, institution, discipline, primaryArea, secondaryArea, tertiaryArea, totalSurveys, city, country, venue_trained, date_trained, address);
		AccreditorUtil accUtil = new AccreditorUtil();
		
		accUtil.addAccreditor(acc, jObj);
			

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
