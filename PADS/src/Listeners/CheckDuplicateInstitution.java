package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Utilities.AccreditorUtil;
import Utilities.InstitutionUtil;
import Utilities.SchoolSystemUtil;

/**
 * Servlet implementation class InstitutionsLoader
 */
@WebServlet("/CheckDuplicateInstitution")
public class CheckDuplicateInstitution extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckDuplicateInstitution() {
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
		InstitutionUtil instUtil = new InstitutionUtil();
		jArray = instUtil.getDuplicateCheckerJSON();
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
