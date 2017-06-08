package Listeners;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.ConfirmationUtil;

/**
 * Servlet implementation class ChangeAccreditor
 */
@WebServlet("/ChangeAccreditor")
public class ChangeAccreditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeAccreditor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int newAccID=Integer.parseInt((String)request.getParameter("newAccreditorID"));
		int oldAccID=Integer.parseInt((String)request.getParameter("oldAccreditorID"));
		int PSID=Integer.parseInt((String)request.getParameter("PSID"));
		int areaID =Integer.parseInt((String)request.getParameter("AreaID"));
		
		ConfirmationUtil cUtil = new ConfirmationUtil();
		cUtil.changeAccreditor(newAccID,PSID,areaID, oldAccID);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
	}

}
