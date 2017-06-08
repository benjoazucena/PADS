package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import Utilities.ProgramUtil;

/**
 * Servlet implementation class LatestAccreditor
 */
@WebServlet("/LatestAccreditor")
public class LatestAccreditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LatestAccreditor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text");
		if(request.getParameter("SPID") != null){
			int SPID = Integer.parseInt(request.getParameter("SPID"));
			int areaID = Integer.parseInt(request.getParameter("areaID"));
			ProgramUtil progUtil = new ProgramUtil();		
			response.getWriter().write(progUtil.getLatestAccreditor(SPID, areaID));	
		}
		else{
			int PSID = Integer.parseInt(request.getParameter("PSID"));
			int areaID = Integer.parseInt(request.getParameter("areaID"));
			ProgramUtil progUtil = new ProgramUtil();			
			response.getWriter().write(progUtil.getLatestAccreditorPSID(PSID, areaID));	
		}
		
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
