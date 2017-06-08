package Listeners;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.InstitutionUtil;

/**
 * Servlet implementation class UpdateInstitution
 */
@WebServlet("/UpdateInstitution")
public class UpdateInstitution extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInstitution() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String ssID = request.getParameter("ssID");
		int institutionID = Integer.parseInt((String)request.getParameter("institutionID"));
		String institutionName = request.getParameter("institutionName");
		
		String institutionAcronym = request.getParameter("institutionAcronym");
		
		String address = request.getParameter("address");
		
		String city = request.getParameter("city");
		
		String country = request.getParameter("country");
		
		String website = request.getParameter("website");
		
		String contactNumber = request.getParameter("contactNumber");
		
		String fax = request.getParameter("fax");
		
		String institutionHead = request.getParameter("institutionHead");
		
		String position = request.getParameter("position");
		
		String headEmail = request.getParameter("headEmail");
		
		String contactPerson = request.getParameter("contactPerson");
		
		String contactPosition = request.getParameter("contactPosition");
		
		String contactEmail = request.getParameter("contactEmail");
		
		String membershipDate  = request.getParameter("membershipDate");
		
		
				
		InstitutionUtil instUtil = new InstitutionUtil();
		instUtil.editInstitution(institutionID, ssID, institutionName, institutionAcronym,  address, city, country, website, contactNumber, fax, institutionHead, position, headEmail, contactPerson, contactPosition, contactEmail, membershipDate);

		RequestDispatcher rd = request.getRequestDispatcher("Institutions");
		rd.forward(request, response);
	}

}
