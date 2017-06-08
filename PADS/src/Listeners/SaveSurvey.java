package Listeners;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import Utilities.SurveyUtil;

/**
 * Servlet implementation class SaveSurvey
 */
@WebServlet("/SaveSurvey")
public class SaveSurvey extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveSurvey() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String obj = request.getParameter("surveyObject");
		JSONObject jObj = new JSONObject(obj);
		
		
		String paascu1Name = (String) jObj.getString("paascu1Name");
		String paascu1Contact = (String)jObj.getString("paascu1Contact");
		String paascu1Position = (String)jObj.getString("paascu1Position");
		
		String paascu2Name = (String) jObj.getString("paascu2Name");
		String paascu2Contact = (String)jObj.getString("paascu2Contact");
		String paascu2Position = (String)jObj.getString("paascu2Position");
		
		int chairpersonID = jObj.getInt("chairpersonID");
		int institutionID = (Integer) jObj.getInt("institutionID");
		int systemID = (Integer) jObj.getInt("systemID");
		
		JSONArray programList = (JSONArray) jObj.getJSONArray("programList");

		
		SurveyUtil surUtil = new SurveyUtil();
		surUtil.saveSurvey(paascu1Name, paascu1Contact, paascu1Position, paascu2Name, paascu2Contact, paascu2Position, chairpersonID,
				institutionID, systemID, programList);
		
		RequestDispatcher rd = request.getRequestDispatcher("survey.jsp");
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
