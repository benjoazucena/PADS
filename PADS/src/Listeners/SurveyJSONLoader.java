package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Utilities.SurveyUtil;

/**
 * Servlet implementation class SurveyJSONLoader
 */
@WebServlet("/SurveyJSONLoader")
public class SurveyJSONLoader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SurveyJSONLoader() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		
		String startDate = (String) request.getParameter("startDate");
		String endDate = (String) request.getParameter("endDate");
//		int surveyID = (int)request.getAttribute("surveyID");
		JSONArray jArray = new JSONArray();
		SurveyUtil surUtil = new SurveyUtil();
		jArray = surUtil.getSurveysJSON(startDate, endDate);
		System.out.println("Getting JSON Survey for " + startDate + " to " + endDate);
		response.getWriter().write(jArray.toString());	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
