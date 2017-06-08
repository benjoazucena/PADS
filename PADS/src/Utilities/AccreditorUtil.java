package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.Connection;

import Models.Accreditation;
import Models.Accreditor;
import Models.Degree;
import Models.Work;

public class AccreditorUtil {
	private DBUtil db;
	public AccreditorUtil(){
		db = new DBUtil();
	}
	private String getDegree(int SPID){
		String title = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE SPID = ?");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			title = rs.getString(9);
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getDegree()");
			e.printStackTrace();
		}
		
		return title;
	}
	public ArrayList<Accreditation> getAccreditations(int accreditorID){
		ArrayList<Accreditation> past = new ArrayList<Accreditation>();
		Accreditation temp = new Accreditation();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT s.surveyID, s.start_date, s.end_date, s.institutionID, ps.survey_type, ps.SPID, pa.areaID, pa.accreditorID FROM `program-area` pa JOIN `program-survey` ps ON pa.PSID = ps.PSID JOIN surveys s ON ps.surveyID = s.surveyID WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			int surveyID = 0; int tempID = 0; int programID = 0; int tempID2 = 0;
			String programs = "";
			String areas = "";
			if(rs.next()){
				do{
					tempID = rs.getInt(1);
					tempID2 = rs.getInt(6);
					
					if(surveyID != tempID){
						temp.setPrograms(programs);
						
						past.add(temp);
						temp = new  Accreditation();
						temp.setInstitution(getInstitution(rs.getInt(4)));
						temp.setFrom(rs.getString(2));	
						temp.setTo(rs.getString(3));
						
						surveyID = tempID;
						programs = "";
						programID = tempID2;

						programs += getDegree(tempID2) + ": <br>";
						programs += getArea(rs.getInt(7)) + " ";
					}else{
						if (programID != tempID2){
							programs += "<br>";
							
							programs = getDegree(tempID2) + ": <br>";
							programs += getArea(rs.getInt(7)) + " ";

							programID = tempID2;
						}else{
							programs += getArea(rs.getInt(7)) + " ";
						}
					}
				}while(rs.next());
			}
			
			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditations()");
			e.printStackTrace();
		}
		return past;
	}
	public String updateConfirmation(int accreditorID, String confirmation, int PSID, int areaID){
		String temp = new String();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET `attendance_confirmation` = ? WHERE accreditorID=? AND PSID = ? AND areaID = ?");
			ps.setString(1, confirmation);
			ps.setInt(2, accreditorID);
			ps.setInt(3, PSID);
			ps.setInt(4, areaID);

			ps.executeUpdate();
			temp = "Successfully updated confirmation!";
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			temp = "Error in updating confirmation!";
			e.printStackTrace();
		}
		return temp;
	}
	public void updateAccreditor(int accreditorID, Accreditor acc, JSONObject affObject){
		try{
			removeAffiliations(accreditorID);

			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `pads`.`accreditors` SET `lastname` = ?, `firstname` = ?, `middlename` = ?, `honorifics` = ?, `email` = ?, `num_surveys` = ?, `date_trained` = ?, `contact` = ?, `address` = ?, `city` = ?, `country` = ?, `venue_trained` = ?, `primaryAreaID` = ?, `secondaryAreaID` = ?, `thirdAreaID` = ?, `discipline` = ? WHERE accreditorID = ?");
			ps.setString(1, acc.getLastName());
			ps.setString(2, acc.getFirstName());
			ps.setString(3, acc.getMiddleName());
			ps.setString(4, acc.getHonorifics());
			ps.setString(5, acc.getEmail());
			ps.setInt(6, acc.getTotalSurveys());
			ps.setString(7, acc.getDate_trained());
			ps.setString(8, acc.getContact());
			ps.setString(9, acc.getAddress());
			ps.setString(10, acc.getCity());
			ps.setString(11, acc.getCountry());
			ps.setString(12, acc.getVenue_trained());
			ps.setInt(13, acc.getPrimaryAreaID());
			ps.setInt(14, acc.getSecondaryAreaID());
			ps.setInt(15, acc.getTertiaryAreaID());
			
			ps.setString(16, acc.getDiscipline());
			ps.setInt(17, accreditorID);
			ps.executeUpdate();

			addAffiliations(affObject, accreditorID);
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:updateAccreditor()");
			e.printStackTrace();
		}
	}
	
	private void removeAffiliations(int accreditorID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from work WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ps.executeUpdate();
			
			ps = conn.prepareStatement("DELETE from `accreditor-degree` WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:removeAffiliations()");
			e.printStackTrace();
		}
	}
	public ArrayList<Accreditor> getAccreditors(){
		ArrayList<Accreditor> accreditors = new ArrayList<Accreditor>();
		Accreditor temp = new Accreditor();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM accreditors");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				
				//int accreditorID, String honorifics, String firstName, String lastName, String middleName,
				//String email, String contact, String institution, String discipline, String primaryArea, String secondaryArea,
				//int totalSurveys, String city, String country, String venue_trained, String date_trained, String address
				
				//db returns accreditorID, lastname, firstname, midlename, honorifics, email, num_surveys, 
				//date_trained, contact, address, city, country, venue_trained, primaryAreaID, 
				//secondaryAreaID, discipline
				
				int accreditorID = rs.getInt(1);
				String honorifics = rs.getString(5);
				String firstName = rs.getString(3);
				String lastName = rs.getString(2);
				String middleName = rs.getString(4);
				String email = rs.getString(6);
				String institution = getLatestAffiliation(accreditorID);
				String discipline = rs.getString(17);
				String primaryArea = getArea(rs.getInt(14));
				String secondaryArea = getArea(rs.getInt(15));
				String tertiaryArea = getArea(rs.getInt(16));
				int totalSurveys = rs.getInt(7);
				String city = rs.getString(11);
				String country = rs.getString(12);
				String venue_trained = rs.getString(13);
				String date_trained = rs.getString(8);
				String address = rs.getString(10);
				String contact = rs.getString(9);
				temp = new Accreditor(accreditorID, honorifics, firstName, lastName, middleName, email, contact, institution, discipline, primaryArea, secondaryArea, tertiaryArea, totalSurveys, city, country, venue_trained, date_trained, address);
				accreditors.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return accreditors;
	}
	private String getLatestAffiliation(int accreditorID){
		String name = null;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM work WHERE accreditorID = ? and date_finished IS NULL");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = getInstitution(rs.getInt(1));
			}
			else name = "No Data"; 
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getLatestAffiliation()");
			e.printStackTrace();
		}
		return name;
	}
	
	private String getArea(int areaID){
		String name = null;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM areas WHERE areaID = ?");
			ps.setInt(1, areaID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			name = rs.getString(1);
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getArea()");
			e.printStackTrace();
		}
		
		return name;
	}
	
	public Accreditor getAccreditor(int accreditorID){
		Accreditor accreditor = new Accreditor();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM accreditors a WHERE a.accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				//int accreditorID, String honorifics, String firstName, String lastName, String middleName,
				//String email, String contact, String institution, String discipline, String primaryArea, String secondaryArea,
				//int totalSurveys, String city, String country, String venue_trained, String date_trained, String address
				
				//db returns accreditorID, lastname, firstname, midlename, honorifics, email, num_surveys, 
				//date_trained, contact, address, city, country, venue_trained, primaryAreaID, 
				//secondaryAreaID, discipline
				String honorifics = rs.getString(5);
				String firstName = rs.getString(3);
				String lastName = rs.getString(2);
				String middleName = rs.getString(4);
				String email = rs.getString(6);
				String institution = getLatestAffiliation(accreditorID);
				String discipline = rs.getString(17);
				String primaryArea = getArea(rs.getInt(14));
				String secondaryArea = getArea(rs.getInt(15));
				String tertiaryArea = getArea(rs.getInt(16));
				int totalSurveys = rs.getInt(7);
				String city = rs.getString(11);
				String country = rs.getString(12);
				String venue_trained = rs.getString(13);
				String date_trained = rs.getString(8);
				String address = rs.getString(10);
				String contact = rs.getString(9);
				accreditor = new Accreditor(accreditorID, honorifics, firstName, lastName, middleName, email, contact, institution, discipline, primaryArea, secondaryArea, tertiaryArea, totalSurveys, city, country, venue_trained, date_trained, address);
				accreditor.addDegrees(getDegrees(accreditorID));
				accreditor.addWorks(getWorks(accreditorID));
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		return accreditor;
	}
	
	private ArrayList<Degree> getDegrees(int accreditorID){
		ArrayList<Degree> degrees = new ArrayList<Degree>();
		Degree temp = new Degree();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `accreditor-degree` WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				temp = new Degree(rs.getString(2), accreditorID, getInstitution(rs.getInt(3)), rs.getInt(3));
				degrees.add(temp);
			}
			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getDegrees()");
			e.printStackTrace();
		}
		return degrees;
	}
	
	private String getInstitution(int institutionID){
		String name = null;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				name = rs.getString(3);
			}else{
				name = "No Data";
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getInstitution()");
			e.printStackTrace();
		}
		
		return name;
	}
	private ArrayList<Work> getWorks(int accreditorID){
		ArrayList<Work> works = new ArrayList<Work>();
		Work temp = new Work();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM work WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				temp = new Work(getInstitution(rs.getInt(2)), accreditorID, rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(2));
				works.add(temp);
			}
			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getDegrees()");
			e.printStackTrace();
		}
		return works;
	}
	
	
	private String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
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
		return format;
	}
	public void addAccreditor(Accreditor acc, JSONObject affObject){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO `pads`.`accreditors` (`lastname`, `firstname`, `middlename`, `honorifics`, `email`, `num_surveys`, `date_trained`, `contact`, `address`, `city`, `country`, `venue_trained`, `primaryAreaID`, `secondaryAreaID`, `tertiaryAreaID`,`discipline`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setString(1, acc.getLastName());
			ps.setString(2, acc.getFirstName());
			ps.setString(3, acc.getMiddleName());
			ps.setString(4, acc.getHonorifics());
			ps.setString(5, acc.getEmail());
			ps.setInt(6, acc.getTotalSurveys());
			ps.setString(7, formatDate(acc.getDate_trained()));
			ps.setString(8, acc.getContact());
			ps.setString(9, acc.getAddress());
			ps.setString(10, acc.getCity());
			ps.setString(11, acc.getCountry());
			ps.setString(12, acc.getVenue_trained());
			ps.setInt(13, acc.getPrimaryAreaID());
			ps.setInt(14, acc.getSecondaryAreaID());
			ps.setInt(15, acc.getTertiaryAreaID());
			ps.setString(16, acc.getDiscipline());
			ps.executeUpdate();
			ps = conn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();
			int accreditorID = rs.getInt(1);
			addAffiliations(affObject, accreditorID);
			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:addAccreditor()");
			e.printStackTrace();
		}
	}
	
	public void addLatestAffiliation(int accreditorID, int institutionID, String start, String position){
		try{
			Connection conn = db.getConnection();
			if(start == null || position == null){
				System.out.println("WALA");
			}
			PreparedStatement ps = conn.prepareStatement("INSERT INTO `work` (institutionID, accreditorID, `date_entered`, `position`) VALUES (?, ?, ?, ?)");
			ps.setInt(1, institutionID);
			ps.setInt(2, accreditorID);
			ps.setString(3, start);
			ps.setString(4, position);
			
			ps.executeUpdate();			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:addWork()");
			e.printStackTrace();	
		}
	}
	public void addAffiliations(JSONObject affObject, int accreditorID){
		JSONArray works = (JSONArray) affObject.getJSONArray("works");
		JSONArray edu = (JSONArray) affObject.getJSONArray("edu");
		JSONObject temp = new JSONObject();

		for(int i = 0; i < works.length(); i++){
			temp = works.getJSONObject(i);
			int institutionID = temp.getInt("institutionID");
			String position = temp.getString("pos");
			String from = formatDate(temp.getString("from"));
			String to = formatDate(temp.getString("to"));
			addWork(accreditorID, institutionID, position, from, to);
		}
		
		for(int j = 0; j < edu.length(); j++){
			temp = edu.getJSONObject(j);
			int institutionID = temp.getInt("institutionID");
			String course = temp.getString("course");
			addEdu(accreditorID, institutionID, course);
		}
	}
	
	public void addWork(int accreditorID, int institutionID, String position, String from, String to){
		try{
			Connection conn = db.getConnection();
			if(to.equals("")){
				PreparedStatement ps = conn.prepareStatement("INSERT INTO `work` (institutionID, accreditorID, `date_entered`, `position`) VALUES (?, ?, ?, ?)");
				
				ps.setInt(1, institutionID);
				ps.setInt(2, accreditorID);
				ps.setString(3, from);
				ps.setString(4, position);
				ps.executeUpdate();	
			}else{
				PreparedStatement ps = conn.prepareStatement("INSERT INTO `work` (institutionID, accreditorID, `date_entered`, `date_finished`, `position`) VALUES (?, ?, ?, ?, ?)");
				
				ps.setInt(1, institutionID);
				ps.setInt(2, accreditorID);
				ps.setString(3, from);
				ps.setString(4, to);
				ps.setString(5, position);
				ps.executeUpdate();	
			}
					
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:addWork()");
			e.printStackTrace();	
		}
	}
	
	public void addEdu(int accreditorID, int institutionID, String course){
		try{
			Connection conn = db.getConnection();

			PreparedStatement ps = conn.prepareStatement("INSERT INTO `accreditor-degree` (accreditorID, `degree_name`, `institutionID`) VALUES (?, ?, ?)");
			ps.setInt(1, accreditorID);
			ps.setString(2, course);
			ps.setInt(3, institutionID);
			ps.executeUpdate();			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:addWork()");
			e.printStackTrace();	
		}
	}
	public void deleteAccreditor(int accreditorID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from accreditors WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:deleteAccreditor()");
			e.printStackTrace();
		}
	}
	
	public JSONArray getAccreditorsJSON(int SPID, int systemID){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT accreditorID, lastname, firstname, middlename, `num_surveys`, city, primaryAreaID, secondaryAreaID, tertiaryAreaID, discipline FROM `accreditors`");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("accreditorName", rs.getString(2) + ", " + rs.getString(3) + " " + rs.getString(4));
				int primaryAreaID = rs.getInt(7);
				if(rs.wasNull()){
					job.put("primaryArea", "None");
				}else{
					job.put("primaryArea", getArea(primaryAreaID));
				}
				
				int secondaryAreaID = rs.getInt(8);
				if(rs.wasNull()){
					job.put("secondaryArea", "None");
				}else{
					job.put("secondaryArea", getArea(secondaryAreaID));
				}
				
				int tertiaryAreaID = rs.getInt(9);
				if(rs.wasNull()){
					job.put("tertiaryArea", "None");
				}else{
					job.put("tertiaryArea", getArea(tertiaryAreaID));
				}
				job.put("primaryAreaID", rs.getInt(7));
				job.put("secondaryAreaID", rs.getInt(8));
				job.put("city", rs.getString(6));
				job.put("discipline", rs.getString(10));
				job.put("numberSurveys", rs.getInt(5));
				job.put("accreditorID", rs.getInt(1));
				job.put("hasAffiliation", checkAffiliations(rs.getInt(1), systemID));
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditorsJSON()");
			e.printStackTrace();
		}
		
		return jArray;
	}
	
	private boolean checkAffiliations(int accreditorID, int systemID){
		boolean nice = false;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM work INNER JOIN institutions ON work.institutionID = institutions.institutionID WHERE accreditorID = ? and systemID = ?");
			ps.setInt(1, accreditorID);
			ps.setInt(2, systemID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				nice = true;
			}else{
				nice = false;
			}
				
			
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:checkAffiliations()");
			e.printStackTrace();
		}
		return nice;
	}
}
