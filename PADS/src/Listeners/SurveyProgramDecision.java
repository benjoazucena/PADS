package Listeners;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.ConfirmationUtil;
import Utilities.SurveyUtil;

/**
 * Servlet implementation class SurveyProgramDecision
 */
@WebServlet("/SurveyProgramDecision")
public class SurveyProgramDecision extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SurveyProgramDecision() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("TYPEEEE");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-	generated method stub
		String type = (String)request.getParameter("type");
		int PSID = Integer.parseInt((String)request.getParameter("PSID"));
		String valid_thru="";
		String fi ="";
		String fc ="";
		String fp ="";
		System.out.println("'"+(String)request.getParameter("decisionDate")+"'DECISION DATE%%%%%%%%");
		String dateApproved= ""+formatDate((String)request.getParameter("decisionDate"));
		
		
		
		if(type.equals("Resurvey")){
			int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
			String decision = (String)request.getParameter("opt");
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);	
		}
		else if(type.equals("Formal")){
			int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
			String decision_team = (String)request.getParameter("opt_team");
			String decision_commission = (String)request.getParameter("opt_commission");
			String decision_board = ""+(String)request.getParameter("opt_board");
			String remarks_team = (String)request.getParameter("remarks_team");
			String remarks_commission = (String)request.getParameter("remarks_commission");
			String remarks_board = (String)request.getParameter("remarks_board");
			
			
			if(decision_board.equals("Initial accreditation for three (3) years")){
				
				String[] parts = dateApproved.split("-");
				int year = Integer.parseInt(parts[0]);
				year += 3;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
			}
			else{
				String[] parts = dateApproved.split("-");
				if(parts.length>1){
				int year = Integer.parseInt(parts[0]);
				year += 1;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
				}
			}
			
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_commission, remarks_commission, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);	
		}
		else if(type.equals("Revisit")){
			int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
			String decision = (String)request.getParameter("opt");
			
			System.out.println("PSID of specified REVIST:" + PSID);
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);	
		}
		else if(type.equals("Consultancy")){
			int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
			String decision_team = ""+(String)request.getParameter("opt_team");
			String decision_commission = ""+(String)request.getParameter("opt_commission");
			String decision_board = ""+(String)request.getParameter("opt_board");
			String remarks_team = ""+(String)request.getParameter("remarks"+PSID+"_team");
			String remarks_commission = ""+(String)request.getParameter("remarks"+PSID+"_commission");
			String remarks_board = ""+(String)request.getParameter("remarks"+PSID+"_board");
						
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_commission, remarks_commission, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);	
				
		}
		else if(type.equals("Preliminary")){
			int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
			String decision_team = ""+(String)request.getParameter("opt_team");
			String decision_commission = ""+(String)request.getParameter("opt_commission");
			String decision_board = ""+(String)request.getParameter("opt_board");
			String remarks_team = ""+(String)request.getParameter("remarks"+PSID+"_team");
			String remarks_commission = ""+(String)request.getParameter("remarks"+PSID+"_commission");
			String remarks_board = ""+(String)request.getParameter("remarks"+PSID+"_board");
			System.out.println(decision_board+"DECISION OF BOARD");
			
					
//			if(decision_board!="" && decision_board!=null){
//				
//				String[] parts = dateApproved.split("-");
//				System.out.println(parts[0]+"PARTS 1");
//				int year = Integer.parseInt(parts[0]);
//				year += 1;
//				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
//				
//				if(decision_board.contains("Consultancy")){
//					String[] parts2 = dateApproved.split("-");
//					fc = valid_thru;
//				}
//			}
						
			
			
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_commission, remarks_commission, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);			
			
		}
		


System.out.println("TYPEEEE");

	}
	
	private static String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if((date == null) || (date.equals("")) || (date.equals(" "))){
		String[] parts = date.split(" ");
		if(parts[0].equals("January")){
			month = "01";
		}else if(parts[0].equals("February")){
			month = "02";
		}else if(parts[0].equals("March")){
			month = "03";
		}else if(parts[0].equals("April")){
			month = "04";
		}else if(parts[0].equals("May")){
			month = "05";
		}else if(parts[0].equals("June")){
			month = "06";
		}else if(parts[0].equals("July")){
			month = "07";
		}else if(parts[0].equals("August")){
			month = "08";
		}else if(parts[0].equals("September")){
			month = "09";
		}else if(parts[0].equals("October")){
			month = "10";
		}else if(parts[0].equals("November")){
			month = "11";
		}else if(parts[0].equals("December")){
			month = "12";
		}
		year = parts[2];

		parts = parts[1].split(",");
		day = parts[0];
		
		format = year + "-" + month + "-"+ day;
		}
		return format;
	}

}
