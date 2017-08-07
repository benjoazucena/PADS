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

/**
 * Servlet implementation class AccreditorsLoader
 */
@WebServlet("/AccreditorsLoader")
public class AccreditorsLoader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccreditorsLoader() {
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
		int systemID = Integer.parseInt(request.getParameter("systemID"));
		int SPID = Integer.parseInt(request.getParameter("SPID"));
		String  area= request.getParameter("areaID");
		jArray = accUtil.getAccreditorsJSON(SPID, systemID, area);
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
