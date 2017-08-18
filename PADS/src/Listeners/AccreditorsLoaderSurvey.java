package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Utilities.AccreditorUtil;

/**
 * Servlet implementation class AccreditorsLoaderSurvey
 */
@WebServlet("/AccreditorsLoaderSurvey")
public class AccreditorsLoaderSurvey extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccreditorsLoaderSurvey() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		JSONArray jArray = new JSONArray();
		AccreditorUtil accUtil = new AccreditorUtil();
		int institutionID = Integer.parseInt(request.getParameter("institutionID"));
		int PSID = Integer.parseInt(request.getParameter("PSID"));
		int areaID = Integer.parseInt(request.getParameter("areaID"));
		jArray = accUtil.getSurveyAccreditorsJSON(institutionID, PSID, areaID);
		response.getWriter().write(jArray.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
