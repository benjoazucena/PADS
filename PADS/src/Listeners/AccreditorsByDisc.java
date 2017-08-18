package Listeners;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Accreditor;
import Utilities.AccreditorUtil;

/**
 * Servlet implementation class AccreditorsByDisc
 */
@WebServlet("/AccreditorsByDisc")
public class AccreditorsByDisc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccreditorsByDisc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int disciplineID = Integer.parseInt(request.getParameter("disciplineID"));
		ArrayList<Accreditor> accreditors = new ArrayList<Accreditor>();
		AccreditorUtil accUtil = new AccreditorUtil();
		if(disciplineID == 0){
			accreditors = accUtil.getAccreditors();
			
		}else{
			accreditors = accUtil.getAccreditorsByDisc(disciplineID);
		}
		request.setAttribute("accreditors", accreditors);
		request.setAttribute("disciplineID", disciplineID);
		RequestDispatcher rd = request.getRequestDispatcher("accreditors.jsp");
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
