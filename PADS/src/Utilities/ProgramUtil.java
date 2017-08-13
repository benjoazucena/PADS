package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.Connection;

import Models.Program;
import Models.ProgramSurvey;
import Models.SchoolProgram;

public class ProgramUtil {
	private DBUtil db;
	public ProgramUtil(){
		db = new DBUtil();
	}
	
	public JSONArray getDisciplines(){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT programID, name FROM `programs`ORDER BY `name`");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("disciplineID", rs.getInt(1));
				job.put("disciplineName", rs.getString(2));
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getDisciplines()");
			e.printStackTrace();
		}

		return jArray;
	}
	
	public JSONArray getProgramsJSON(int institutionID){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT SPID, degree_name, next_survey_type FROM `school-program` WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("SPID", rs.getInt(1));
				job.put("degreeName", rs.getString(2));
				job.put("surveyType", rs.getString(3));
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getProgramsJSON()");
			e.printStackTrace();
		}
		
		return jArray;
	}
	
	public ArrayList<Program> getPrograms(){
		ArrayList<Program> programs = new ArrayList<Program>();
		Program temp = new Program();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM programs");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				//constructor is (int accreditorID, String name, String institution, String discipline, String primaryArea, 
				// String secondaryArea, int totalSurveys, String city)
				//db returns accreditorID, lastname, firstname, midlename, honorifics, 
				//email, num_surveys, date_trained, contact, address, city, country, venue_trained
				temp = new Program(rs.getInt(1), rs.getString(2), rs.getString(3), getCount(rs.getInt(1)));
				System.out.println(rs.getString(2));
				programs.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getPrograms()");
			e.printStackTrace();
		}
		
	    return programs;
	}
	
	public ArrayList<SchoolProgram> getInstitutionPrograms(int instID){
		ArrayList<SchoolProgram> sps = new ArrayList<SchoolProgram>();
		SchoolProgram sp = new SchoolProgram();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE institutionID=?");
			ps.setInt(1, instID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				sp = new SchoolProgram(rs.getInt(1), getInstitution(rs.getInt(3)), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				sp.setLastSurveyDate(getLastSurveyDate(rs.getInt(3)));
				sps.add(sp);
			}
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getSps()");
			e.printStackTrace();
		}
		return sps;
	}
	
	private String getLastSurveyDate(int instID){
		String last="";
		int latestDate = 0;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `end_date` FROM `surveys` WHERE institutionID=?");
			ps.setInt(1, instID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				System.out.println("0 ---- "+rs.getString(1));
				if(latestDate<Integer.parseInt(rs.getString(1).replace("-",""))){
					latestDate = Integer.parseInt(rs.getString(1).replace("-",""));
					last = rs.getString(1);
				}
			}
		
			if(latestDate == 0){
				last ="NA";
			}
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getSps()");
			e.printStackTrace();
		}
		
		return last;
	}
	public ArrayList<SchoolProgram> getDisciplines(int programID){
		ArrayList<SchoolProgram> sps = new ArrayList<SchoolProgram>();
		SchoolProgram sp = new SchoolProgram();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE programID=?");
			ps.setInt(1, programID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				sp = new SchoolProgram(rs.getInt(1), getInstitution(rs.getInt(3)), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				sps.add(sp);
			}
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getSps()");
			e.printStackTrace();
		}
		return sps;
	}
	public void updateProgram(int programID, String programName){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE programs SET name = ? WHERE programID=?");
			ps.setInt(2, programID);
			ps.setString(1, programName);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
	}
	public Program getProgram(int programID){
		Program temp = new Program();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM programs WHERE programID=?");
			ps.setInt(1, programID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			temp = new Program(rs.getInt(1), rs.getString(2), rs.getString(3), getCount(rs.getInt(1)));
			temp.setSps(getSps(programID));
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getProgram()");
			e.printStackTrace();
		}
		
	    return temp;
	}
	
	private ArrayList<SchoolProgram> getSps(int programID){
		ArrayList<SchoolProgram> sps = new ArrayList<SchoolProgram>();
		SchoolProgram sp = new SchoolProgram();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE programID=?");
			ps.setInt(1, programID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				sp = new SchoolProgram(rs.getInt(1), getInstitution(rs.getInt(3)), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
				sps.add(sp);
			}
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getSps()");
			e.printStackTrace();
		}
		return sps;
	}
	private String getInstitution(int institutionID){
		String temp = new String();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions WHERE institutionID=?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			temp = rs.getString(3);
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getInstitution()");
			e.printStackTrace();
		}
		
		return temp;
	}
	private int getCount(int programID){
		int count = 0;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT count(*) FROM `school-program` WHERE programID = ?");
			ps.setInt(1, programID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getCount()");
			e.printStackTrace();
		}
		return count;
	}
	public void addProgram(String programName, String acronym){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO programs (name, acronym) VALUES (?, ?)");
			ps.setString(1, programName);
			ps.setString(2, acronym);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:addProgram()");
			e.printStackTrace();	
		}
	}
	
	public void editProgram(int programID, String name, String acronym){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE programs SET name = ? WHERE programID = ?");
			ps.setString(1, name);
			ps.setInt(2, programID);
			ps.executeUpdate();
			ps = conn.prepareStatement("UPDATE programs SET acronym = ? WHERE programID = ?");
			ps.setString(1, acronym);
			ps.setInt(2, programID);
			ps.executeUpdate();

		} catch (Exception e){
			System.out.println("Error in ProgramUtil:editProgram()");
			e.printStackTrace();
		}
	}
	
	public void deleteProgram(int programID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from programs WHERE programID = ?");
			ps.setInt(1, programID);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:deleteProgram()");
			e.printStackTrace();
		}
	}
	
	public String getLatestAccreditor(int SPID, int areaID){
		String temp = "";
		int PSID = getLatestPSID(SPID);
		if (PSID == 0){
			temp = "No Data";
		}else{
			try{
				Connection conn = db.getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM `program-area` WHERE areaID = ? and PSID = ?");
				ps.setInt(1, areaID);
				ps.setInt(2, PSID);
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					try{
						temp = getAccreditorName(rs.getInt(3));
					}catch(Exception e){
						temp = "No Data";
					}
				}else{
					System.out.println("No data for areaID: " + areaID + " - PSID: " + PSID);
					temp = "No Data";
				}
			
			} catch (Exception e){
				System.out.println("Error in ProgramUtil:getInstitution()");
				e.printStackTrace();
			}
		}
		return temp;
	}

	public String getLatestAccreditorPSID(int PSID, int areaID){
		String temp = "";
		
			temp = "No Data";
	
			try{
				Connection conn = db.getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM `program-area` WHERE areaID = ? and PSID = ?");
				ps.setInt(1, areaID);
				ps.setInt(2, PSID);
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					temp = getAccreditorName(rs.getInt(3));
				}else{
					System.out.println("No data for areaID: " + areaID + " - PSID: " + PSID);
					temp = "No Data";
				}
			
			} catch (Exception e){
				System.out.println("Error in ProgramUtil:getInstitution()");
				e.printStackTrace();
			}
		
		return temp;
	}
	private String getAccreditorName(int accreditorID){
		String temp = "";
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `accreditors` WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			System.out.println("Debug getAccreditorName: " + accreditorID);

			ResultSet rs = ps.executeQuery();
			
			if(!rs.next()){
				temp = "Accreditor has been removed";
			}else{
				System.out.println("Debug getAccreditorName: " + rs.getString(4));
			if(rs.getString(4) == null){
				temp = rs.getString(2) + ", " + rs.getString(3);
			}else{
				temp = rs.getString(2) + ", " + rs.getString(3) + " " + rs.getString(4);

			}
			}
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getAccreditorName()");
			e.printStackTrace();
		}
		return temp;
	}
	private int getLatestPSID(int SPID){
		int temp = 0;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT max(PSID) FROM `program-survey` WHERE SPID = ?");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				temp = rs.getInt(1);
			}else{
				temp = 0;
			}
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getInstitution()");
			e.printStackTrace();
		}
		
		return temp;
	}
	

	public ArrayList<ProgramSurvey> getInstitutionProgramSurvey(int SPID){
		ArrayList<ProgramSurvey> hist= new ArrayList();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `PSID`, `surveyID`, `survey_type`, `valid_thru`, `boardApprovalDate` FROM `program-survey` WHERE SPID = ? AND currentDecisionBy = 'Board' ");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String surveydate = getSurveyDate(rs.getInt(2));
				String decision = getBoardDecision(rs.getInt(1));
				
				ProgramSurvey temp = new ProgramSurvey();
				temp.setBoard_decision(decision);
				temp.setDecision_date(rs.getString(5));
				temp.setSurveyDate(surveydate);
				temp.setSurvey_type(rs.getString(3));
				temp.setValid_thru(rs.getString(4));
				hist.add(temp);
			}
	
		
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getInstitution()");
			e.printStackTrace();
		}
		
		return hist;
	}
	
	private String getSurveyDate(int surveyID){
		String temp = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `start_date`, `end_date` FROM `surveys` WHERE surveyID = ?");
			ps.setInt(1, surveyID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(rs.getString(2))){
					temp = formatDate(rs.getString(1));
				}else{
					temp = rs.getString(1) + "\n" + formatDate(rs.getString(2));
				}
			}
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getInstitution()");
			e.printStackTrace();
		}
		
		return temp;
	}
	private String getBoardDecision(int PSID){
		String temp = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `decision`, `remarks` FROM `decisions` WHERE PSID = ?");
			ps.setInt(1, PSID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				if(rs.getString(2).equals("undefined")||rs.getString(2).equals("NA")||rs.getString(2).equals("")){
					temp = rs.getString(1);
				}else{
					temp = rs.getString(1) + " " + rs.getString(2);
				}
			}
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:getBoardDecison()");
			e.printStackTrace();
		}
		
		return temp;
	}
	
	private static String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if(date==null||date.equals("")||date.equals(" ")){}
		else{
		String[] parts = date.split("-");
		if(parts[1].equals("01")){
			month = "January";
		}else if(parts[1].equals("02")){
			month = "February";
		}else if(parts[1].equals("03")){
			month = "March";
		}else if(parts[1].equals("04")){
			month = "April";
		}else if(parts[1].equals("05")){
			month = "May";
		}else if(parts[1].equals("06")){
			month = "June";
		}else if(parts[1].equals("07")){
			month = "July";
		}else if(parts[1].equals("08")){
			month = "August";
		}else if(parts[1].equals("09")){
			month = "September";
		}else if(parts[1].equals("10")){
			month = "October";
		}else if(parts[1].equals("11")){
			month = "November";
		}else if(parts[1].equals("12")){
			month = "December";
		}
		year = parts[0];

//		parts = parts[1].split(",");
		day = parts[2];
		
		format = month + " " + day + ", "+ year;
		}
		return format;
	}

	
}
