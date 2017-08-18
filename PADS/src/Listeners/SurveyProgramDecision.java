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
//		System.out.println("TYPEEEE");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-	generated method stub
		String type = (String)request.getParameter("type");
		String optionID_team = (String)request.getParameter("optionID_team");
		String optionID_committee = (String)request.getParameter("optionID_committee");
		String optionID_board = (String)request.getParameter("optionID_board");
		int PSID = Integer.parseInt((String)request.getParameter("PSID"));
		int surveyID = Integer.parseInt((String)request.getParameter("surveyID"));
		String valid_thru="";
		String fi ="";
		String fc ="";
		String fp ="";
		System.out.println("'"+(String)request.getParameter("decisionDate")+"'DECISION DATE%%%%%%%%");
		
		String dateApproved= ""+formatDate((String)request.getParameter("decisionDate"));
		
		
		
		if(type.equals("Resurvey")){
		String decision_team="",decision_committee="",decision_board="";
		
	//TEAM DECISION
			if(optionID_team.equals("rsOpt1")){
				String year_team = (String)request.getParameter("yearRsOpt1_team");
				decision_team = "Re-accreditation after a period of "+year_team+" years";
			}
			else if(optionID_team.equals("rsOpt2")){
				String year_team = (String)request.getParameter("yearRsOpt2_team");
				String year2_team = (String)request.getParameter("year2RsOpt2_team");
				String areas_team = (String)request.getParameter("areasRsOpt2_team");
				decision_team = "Re-accreditation after a period of "+year_team+" years with a written progress report on the "+year2_team+ " year for the following areas: "+areas_team;
			}
			else if(optionID_team.equals("rsOpt3")){
				String year_team = (String)request.getParameter("yearRsOpt3_team");
				String year2_team = (String)request.getParameter("year2RsOpt3_team");
				String areas_team = (String)request.getParameter("areasRsOpt3_team");
				decision_team = "Re-accreditation after a period of "+year_team+" years with an Interim visit on the "+year2_team+ " year for the following areas: "+areas_team;
			}
			else if(optionID_team.equals("rsOpt4")){
			
				String reasons_team = (String)request.getParameter("reasonsRsOpt4_team");
				decision_team = "Re-accreditation deferred";
			}
	//COMMITTEE DECISION		
			if(optionID_committee.equals("rsOpt1")){
				String year_committee = (String)request.getParameter("yearRsOpt1_committee");
				decision_committee = "Re-accreditation after a period of "+year_committee+" years";
			}
			else if(optionID_committee.equals("rsOpt2")){
				String year_committee = (String)request.getParameter("yearRsOpt2_committee");
				String year2_committee = (String)request.getParameter("year2RsOpt2_committee");
				String areas_committee = (String)request.getParameter("areasRsOpt2_committee");
				decision_committee = "Re-accreditation after a period of "+year_committee+" years with a written progress report on the "+year2_committee+ " year for the following areas: "+areas_committee;
			}
			else if(optionID_committee.equals("rsOpt3")){
				String year_committee = (String)request.getParameter("yearRsOpt3_committee");
				String year2_committee = (String)request.getParameter("year2RsOpt3_committee");
				String areas_committee = (String)request.getParameter("areasRsOpt3_committee");
				decision_committee = "Re-accreditation after a period of "+year_committee+" years with an Interim visit on the "+year2_committee+ " year for the following areas: "+areas_committee;
			}
			else if(optionID_committee.equals("rsOpt4")){
			
				String reasons_committee = (String)request.getParameter("reasonsRsOpt4_committee");
				decision_committee = "Re-accreditation deferred";
			}
	//BOARD DECISION		
			if(optionID_board.equals("rsOpt1")){
				String year_board = (String)request.getParameter("yearRsOpt1_board");
				decision_board = "Re-accreditation after a period of "+year_board+" years";
			}
			else if(optionID_board.equals("rsOpt2")){
				String year_board = (String)request.getParameter("yearRsOpt2_board");
				String year2_board = (String)request.getParameter("year2RsOpt2_board");
				String areas_board = (String)request.getParameter("areasRsOpt2_board");
				decision_board = "Re-accreditation after a period of "+year_board+" years with a written progress report on the "+year2_board+ " year for the following areas: "+areas_board;
			}
			else if(optionID_board.equals("rsOpt3")){
				String year_board = (String)request.getParameter("yearRsOpt3_board");
				String year2_board = (String)request.getParameter("year2RsOpt3_board");
				String areas_board = (String)request.getParameter("areasRsOpt3_board");
				decision_board = "Re-accreditation after a period of "+year_board+" years with an Interim visit on the "+year2_board+ " year for the following areas: "+areas_board;
			}
			else if(optionID_board.equals("rsOpt4")){
			
				String reasons_board = (String)request.getParameter("reasonsRsOpt4_board");
				decision_board = "Re-accreditation deferred";
			}
			
			
			System.out.println(decision_board+"+++BOARD++++FINAAAAAAALLYYYYYYY!!!!!!!!!!!!!!!!!!!!!!!!!!");
			
			
			response.sendRedirect("ConfirmationPage?surveyID="+surveyID);
			
		}
		else if(type.equals("Formal")){
		
			String decision_team = (String)request.getParameter("opt_team");
			String decision_committee = (String)request.getParameter("opt_committee");
			String decision_board = ""+(String)request.getParameter("opt_board");
			String remarks_team = (String)request.getParameter("remarks_team");
			String remarks_committee = (String)request.getParameter("remarks_committee");
			String remarks_board = (String)request.getParameter("remarks_board");
			
			
			if(decision_board.equals("NA")){}
					
			else if(decision_board.equals("Initial accreditation for three (3) years")){
				
				String[] parts = dateApproved.split("-");
				int year = Integer.parseInt(parts[0]);
				year += 3;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
			}
			else{
				String[] parts = dateApproved.split("-");
				if(parts.length>1){
				int year = Integer.parseInt(parts[0]);
				year += 3;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
				}
			}
			
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_committee, remarks_committee, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmationPage?surveyID="+surveyID);
			rd.forward(request, response);	
		}
		else if(type.equals("Revisit")){
			
			String decision = (String)request.getParameter("opt");
			
//			System.out.println("PSID of specified REVIST:" + PSID);
			
			response.sendRedirect("ConfirmationPage?surveyID="+surveyID);
		}
		else if(type.equals("Consultancy")){

			String decision_team = ""+(String)request.getParameter("opt_team");
			String decision_committee = ""+(String)request.getParameter("opt_committee");
			String decision_board = ""+(String)request.getParameter("opt_board");
			String remarks_team = ""+(String)request.getParameter("remarks"+PSID+"_team");
			String remarks_committee = ""+(String)request.getParameter("remarks"+PSID+"_committee");
			String remarks_board = ""+(String)request.getParameter("remarks"+PSID+"_board");
			
			if(decision_board.equals("NA")){}
			else{
				
				String[] parts = dateApproved.split("-");
				System.out.println(parts[0]+"PARTS 1");
				int year = Integer.parseInt(parts[0]);
				year += 1;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
				
				if(decision_board.contains("Consultancy")){
					String[] parts2 = dateApproved.split("-");
					fc = valid_thru;
				}
			}
						
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_committee, remarks_committee, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			
			response.sendRedirect("ConfirmationPage?surveyID="+surveyID);	
				
		}
		else if(type.equals("Preliminary")){
			
			String decision_team = ""+(String)request.getParameter("opt_team");
			String decision_committee = ""+(String)request.getParameter("opt_committee");
			String decision_board = (String)request.getParameter("opt_board");
			String remarks_team = ""+(String)request.getParameter("remarks"+PSID+"_team");
			String remarks_committee = ""+(String)request.getParameter("remarks"+PSID+"_committee");
			String remarks_board = ""+(String)request.getParameter("remarks"+PSID+"_board");
		System.out.println(decision_board+"DECISION OF BOARD");
			
					
			if(decision_board.equals("NA")){}
			else{
				
				String[] parts = dateApproved.split("-");
				System.out.println(parts[0]+"PARTS 1");
				int year = Integer.parseInt(parts[0]);
				year += 1;
				valid_thru = Integer.toString(year) +"-"+parts[1]+"-"+ parts[2];
				
				if(decision_board.contains("Consultancy")){
					String[] parts2 = dateApproved.split("-");
					fc = valid_thru;
				}
			}
						
			
			
			ConfirmationUtil cUtil = new ConfirmationUtil();
			cUtil.updateDecision(decision_team, remarks_team, decision_committee, remarks_committee, decision_board, remarks_board, valid_thru,"","","","","","","","","", PSID,dateApproved);
					
			response.sendRedirect("ConfirmationPage?surveyID="+surveyID);
					
			
		}
		


System.out.println("TYPEEEE");

	}
	
	private static String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if((date == null) || (date.equals("")) || (date.equals(" "))){}
		else{
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
