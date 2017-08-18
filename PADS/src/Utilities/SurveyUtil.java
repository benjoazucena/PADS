package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.Connection;

import Models.Accreditor;

public class SurveyUtil {
	private DBUtil db;
	public SurveyUtil(){
		db = new DBUtil();
	}
	public String scheduleSurvey(int surveyID, String start, String end){
		String temp = new String();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `surveys` SET `start_date` = ? , `end_date` = ? WHERE surveyID=?");
			ps.setString(1, start);
			ps.setString(2, end);
			ps.setInt(3, surveyID);
			ps.executeUpdate();
			temp = "Successfully scheduled survey!";
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:scheduleSurvey()");
			temp = "Error in scheduling survey!";
			e.printStackTrace();
		}
		return temp;
	}
	
	public void deleteProgramArea(int accreditorID, int PSID, int areaID){
		try{
			Connection conn = db.getConnection();
			if(accreditorID == 0){
				PreparedStatement ps = conn.prepareStatement("DELETE from `program-area` WHERE PSID = ? and areaID = ?");
				ps.setInt(1, PSID);
				ps.setInt(2, areaID);
				ps.executeUpdate();
			}else{
				PreparedStatement ps = conn.prepareStatement("DELETE from `program-area` WHERE PSID = ? and accreditorID = ? and areaID = ?");
				ps.setInt(1, PSID);
				ps.setInt(2, accreditorID);
				ps.setInt(3, areaID);			
				ps.executeUpdate();
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:deleteProgramArea()");
			e.printStackTrace();
		}
	}
	
	public void updateAccreditor(int accreditorID, int PSID, int areaID, int changeID){
		try{
			Connection conn = db.getConnection();
			if(accreditorID == 0){
				PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET `accreditorID` = ? WHERE PSID = ? AND areaID = ?");
				ps.setInt(1, changeID);
				ps.setInt(2, PSID);
				ps.setInt(3, areaID);
				ps.executeUpdate();
			}else{
				PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET `accreditorID` = ? WHERE accreditorID = ? AND PSID = ? AND areaID = ?");
				ps.setInt(1, changeID);
				ps.setInt(2, accreditorID);
				ps.setInt(3, PSID);
				ps.setInt(4, areaID);			
				ps.executeUpdate();
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:deleteProgramArea()");
			e.printStackTrace();
		}
	}
	
	public void updateSurveyType(int PSID, String type){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-survey` SET `survey_type` = ?  WHERE PSID=?");
			ps.setString(1, type);
			ps.setInt(2,PSID);

			ps.executeUpdate();
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:updateSurveyType()");
			
			e.printStackTrace();
		}
	
	}
	
	public String deletePSID(int PSID){
		String temp = new String();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from `program-survey` WHERE PSID = ?");
			ps.setInt(1, PSID);
			ps.executeUpdate();
			temp = "Successfully deleted the program!";
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:deletePSID()");
			e.printStackTrace();
			return "Error in deleting the program!";
		}
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from `program-area` WHERE PSID = ?");
			ps.setInt(1, PSID);
			ps.executeUpdate();
			temp = "Successfully deleted the program!";
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:deletePSID()");
			e.printStackTrace();
			return "Error in deleting the program!";
		}
		return temp;
	}
	
	public JSONArray getPendingSurveys(){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM surveys WHERE `start_date` IS NULL");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				JSONArray programSurvey = new JSONArray();
				job.put("id", rs.getInt(1));
				job.put("title", getTitle(rs.getInt(6)));
				job.put("institutionName", getInstitution(rs.getInt(6)));
				job.put("institutionCity", getInstitutionCity(rs.getInt(6)));
				job.put("start", rs.getString(2));
				job.put("endDate", rs.getString(3));
				job.put("dateRequested", rs.getString(5));
				job.put("dateApproved", rs.getString(4));
				job.put("paascu1Name", rs.getString(7));
				job.put("paascu1Position", rs.getString(8));
				job.put("paascu2Name", rs.getString(10));
				job.put("paascu2Position", rs.getString(11));
				ArrayList<String> chairperson = getAccreditorAffiliation(rs.getInt(12));
				job.put("chairpersonName", chairperson.get(0));
				job.put("chairpersonInstitution", chairperson.get(1));
				job.put("chairpersonPosition", chairperson.get(2));
				job.put("chairpersonCity", chairperson.get(3));
				programSurvey = getPS(rs.getInt(1));
				
				job.put("programs", programSurvey);
				
				String leastDecBy = new String();
				String tempDecBy = "None";
				
				int i = ((JSONArray) job.get("programs")).length();
				for(int j = 0; j<i;j++){
					String com = ((JSONObject) ((JSONArray) job.get("programs")).get(j)).get("completeness").toString();	
					String decBy;
					if ( ((JSONObject) ((JSONArray) job.get("programs")).get(j)).has("decisionBy")){
						decBy = ((JSONObject) ((JSONArray) job.get("programs")).get(j)).get("decisionBy").toString();
					}else{
						decBy = "None";
					}
					
					if(!decBy.equals("None")){
						if(j == 0){
							tempDecBy = decBy;
						}else{
							if(decBy.equals("Team")){
								tempDecBy = "Team";
							}else if(decBy.equals("Commitee") && !tempDecBy.equals("Team")){
								tempDecBy = "Commitee";
							}
						}
					}
					
					if (decBy.equals("None") && !job.has("status")){
						job.put("status", "unconfirmed");
					}else{
						
					}
					
					if (com.equals("incomplete") && !job.has("completeness")){
						job.put("completeness", "incomplete");
					}
					
					
				}
				
				
				if(!job.has("completeness")){
					job.put("completeness", "complete");
				}
				if(!job.has("status")){
					job.put("status", "confirmed");
				}
				
				job.put("backgroundColor", "rgb(91, 9, 9)");
				job.put("borderColor", "rgb(91, 9, 9)");
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getSurveys()");
			e.printStackTrace();
		}
		
		return jArray;
	}

	public void saveSurvey(String paascu1Name, String paascu1Contact, String paascu1Position,
			String paascu2Name, String paascu2Contact, String paascu2Position, int chairpersonID,
			int institutionID, int systemID, JSONArray programList){
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO `surveys` (institutionID, paascu1Name, paascu1Contact, paascu1Position, paascu2Name, paascu2Contact, paascu2Position, chairpersonID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, institutionID);
			
			ps.setString(2, paascu1Name);
			ps.setString(3, paascu1Contact);
			ps.setString(4, paascu1Position);

			ps.setString(5, paascu2Name);
			ps.setString(6, paascu2Contact);
			ps.setString(7, paascu2Position);
			
			ps.setInt(8, chairpersonID);
			
			ps.executeUpdate();
			ps = conn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();
			int surveyID = rs.getInt(1);
			
			saveProgramList(surveyID, programList);
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:saveSurvey()");
			e.printStackTrace();	
		}
	}
	
	private void saveProgramList(int surveyID, JSONArray programList){
		try{
			Connection conn = db.getConnection();

			JSONObject temp = new JSONObject();
			JSONArray areas = new JSONArray();
			String type = new String();
			int SPID = 0;
			int PSID = 0;
			
			for(int i = 0; i < programList.length(); i++){
				temp = programList.getJSONObject(i);
				System.out.println("PROGRAM: " + temp.getString("SPID") );

				areas = temp.getJSONArray("areas");
				type = temp.getString("surveyType");
				SPID = temp.getInt("SPID");
				PreparedStatement ps = conn.prepareStatement("INSERT INTO `program-survey` (surveyID, SPID, `survey_type`) VALUES (?, ?, ?)");
				ps.setInt(1, surveyID);
				ps.setInt(2, SPID);
				ps.setString(3, type);
				ps.executeUpdate();
				
				ps = conn.prepareStatement("SELECT LAST_INSERT_ID()");
				ResultSet rs = ps.executeQuery();
				rs.next();
				PSID = rs.getInt(1);
				createDecision(PSID);
				saveAreaList(PSID, areas);
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:saveProgramList()");
			e.printStackTrace();	
		}
	}
	
	private void saveAreaList(int PSID, JSONArray areas){
		try{
			Connection conn = db.getConnection();

			JSONObject temp = new JSONObject();
			int areaID = 0;
			int accreditorID = 0;
			JSONArray accs = new JSONArray();
			for(int i = 0; i < areas.length(); i++){
				temp = areas.getJSONObject(i);
				areaID = temp.getInt("areaID");
				accs = temp.getJSONArray("accreditorIDs");
				
				if(accs.length() == 0){
					PreparedStatement ps = conn.prepareStatement("INSERT INTO `program-area` (PSID, areaID, position, `attendance_confirmation`) VALUES (?, ?, ?, ?)");
					ps.setInt(1, PSID);
					ps.setInt(2, areaID);
					ps.setString(3, "None");
					ps.setString(4, "Unconfirmed");
					ps.executeUpdate();

				}
				for(int j = 0; j < accs.length(); j++){
					accreditorID = accs.getInt(j);
					PreparedStatement ps = conn.prepareStatement("INSERT INTO `program-area` (PSID, areaID, accreditorID, position, `attendance_confirmation`) VALUES (?, ?, ?, ?, ?)");
					ps.setInt(1, PSID);
					ps.setInt(2, areaID);
					ps.setInt(3, accreditorID);
					ps.setString(4, "Accreditor");
					ps.setString(5, "Unconfirmed");
					ps.executeUpdate();
				}
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:saveAreaList()");
			e.printStackTrace();	
		}
	}
	
	private void createDecision(int PSID){
		try{
			Connection conn = db.getConnection();

					PreparedStatement ps = conn.prepareStatement("INSERT INTO `decisions` (PSID, decisionBy) VALUES (?, ?)");
					ps.setInt(1, PSID);
					ps.setString(2, "Board");
					
					ps.executeUpdate();
					ps.close();
					
					ps = conn.prepareStatement("INSERT INTO `decisions` (PSID, decisionBy) VALUES (?, ?)");
					ps.setInt(1, PSID);
					ps.setString(2, "Commission");
					
					ps.executeUpdate();
					ps.close();
					
					ps = conn.prepareStatement("INSERT INTO `decisions` (PSID, decisionBy) VALUES (?, ?)");
					ps.setInt(1, PSID);
					ps.setString(2, "Team");
					
					ps.executeUpdate();
					ps.close();

							
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:creatDecision()");
			e.printStackTrace();	
		}
	}
	
	public JSONArray getSurveysJSON(String start, String end){
		JSONArray jArray = new JSONArray();
		JSONObject day = new JSONObject();
		String curDate = "";
		JSONArray institutions = new JSONArray();
		int i = 0;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM surveys WHERE `start_date` >= ? AND `start_date` <= ? ORDER BY `start_date`");
			ps.setString(1, start);
			ps.setString(2, end);
			ResultSet rs = ps.executeQuery();

			while(rs.next()){
				String newDate = rs.getString(2);

				if(i == 0){
					i++;
				}else if( (!(newDate.equalsIgnoreCase(curDate)))){
					day = new JSONObject();
					day.put("institutions", institutions);
					day.put("start", curDate);

					jArray.put(day);
					
					institutions = new JSONArray();
				}
				
				String insAcr = getTitle(rs.getInt(6));
				int surveyID = rs.getInt(1);
				JSONObject institution = getExpanded(insAcr, surveyID);
				institutions.put(institution);
				
				if(rs.isLast()){
					day = new JSONObject();
					day.put("start", newDate);
					day.put("institutions", institutions);
					jArray.put(day);
				}
				curDate = newDate;
				
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getSurveysJSON()");
			e.printStackTrace();
		}
		return jArray;
	}
	
	private JSONObject getExpanded(String insAcr, int surveyID){
		JSONObject ins = new JSONObject();
		JSONArray programs = new JSONArray();
		
		JSONObject program = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `program-survey` WHERE surveyID = ?");
			ps.setInt(1,  surveyID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String surveyType = rs.getString(4);
				int SPID = rs.getInt(3);
				int programID = getProgramID(SPID);
				String proAcr = getProgramAcronym(programID);
				
				program = new JSONObject();
				program.put("proAcr", proAcr);
				if(surveyType.equals("Preliminary")){
					surveyType = "PRE";
				}else if(surveyType.equals("Formal")){
					surveyType = "FOR";
				}else if(surveyType.equals("Resurvey")){
					surveyType = "RES";
				}else if(surveyType.equals("Consultancy")){
					surveyType = "CON";
				}else if(surveyType.equals("Revisit")){
					surveyType = "REV";
				}else if(surveyType.equals("Interim")){
					surveyType = "INT";
				}
				program.put("surveyType", surveyType);
				
				programs.put(program);
			}
			
			ins.put("insAcr", insAcr);
			ins.put("programs", programs);
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getExpanded()");
			e.printStackTrace();
		}
		
		return ins;
	}
	
	private String getProgramAcronym(int programID){
		String acr = "NaN";
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `programs` WHERE programID = ?");
			ps.setInt(1, programID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			if(rs.wasNull()){
				acr = "NaN";
			}else{
			acr = rs.getString(3);
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getProgramAcronym()");
			e.printStackTrace();
		}
		
		return acr;
	}
	private int getProgramID(int SPID){
		int programID = 0;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE SPID = ?");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			programID = rs.getInt(2);
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getProgramID()");
			e.printStackTrace();
		}
		
		return programID;
	}
	
	public JSONArray getSurveys(){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM surveys WHERE `start_date` IS NOT NULL");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				JSONArray programSurvey = new JSONArray();
				job.put("id", rs.getInt(1));
				job.put("title", getTitle(rs.getInt(6)));
				job.put("institutionID", rs.getInt(6));
				job.put("institutionName", getInstitution(rs.getInt(6)));
				job.put("institutionCity", getInstitutionCity(rs.getInt(6)));
				job.put("start", rs.getString(2));
				job.put("endDate", rs.getString(3));
				job.put("dateRequested", rs.getString(5));
				job.put("dateApproved", rs.getString(4));
				job.put("paascu1Name", rs.getString(7));
				job.put("paascu1Position", rs.getString(8));
				job.put("paascu2Name", rs.getString(10));
				job.put("paascu2Position", rs.getString(11));
				ArrayList<String> chairperson = getAccreditorAffiliation(rs.getInt(13));
				job.put("chairpersonName", chairperson.get(0));
				job.put("chairpersonInstitution", chairperson.get(1));
				job.put("chairpersonPosition", chairperson.get(2));
				job.put("chairpersonCity", chairperson.get(3));
				programSurvey = getPS(rs.getInt(1));
				
				job.put("programs", programSurvey);
				
				String leastDecBy = new String();
				String tempDecBy = "None";
				
				int i = ((JSONArray) job.get("programs")).length();
				for(int j = 0; j<i;j++){
					String com = ((JSONObject) ((JSONArray) job.get("programs")).get(j)).get("completeness").toString();	
					String decBy;
					if ( ((JSONObject) ((JSONArray) job.get("programs")).get(j)).has("decisionBy")){
						decBy = ((JSONObject) ((JSONArray) job.get("programs")).get(j)).get("decisionBy").toString();
					}else{
						decBy = "None";
					}
					
					if(!decBy.equals("None")){
						if(j == 0){
							tempDecBy = decBy;
						}else{
							if(decBy.equals("Team")){
								tempDecBy = "Team";
							}else if(decBy.equals("Commitee") && !tempDecBy.equals("Team")){
								tempDecBy = "Commitee";
							}
						}
					}
					
					if (decBy.equals("None") && !job.has("status")){
						job.put("status", "unconfirmed");
					}else{
						
					}
					
					if (com.equals("incomplete") && !job.has("completeness")){
						job.put("completeness", "incomplete");
					}
					
					
				}
				
				
				if(!job.has("completeness")){
					job.put("completeness", "complete");
				}
				if(!job.has("status")){
					job.put("status", "confirmed");
				}
				
				
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date();
				Date date2 = dateFormat.parse(job.getString("start"));
				
				if(date2.before(date)){
					
					
					if(job.get("status").equals("confirmed") ){
						job.put("backgroundColor", "rgb(12, 48, 107)");
						if(tempDecBy.equals("Team")){
							job.put("borderColor", "rgb(149, 209, 229)");
						}else if(tempDecBy.equals("Board")){
							job.put("borderColor", "rgb(234, 232, 114)");
						}else if(tempDecBy.equals("Commission")){
							job.put("borderColor", "rgetgb(12, 48, 107)");
						}
						
					}else if(job.get("status").equals("unconfirmed")){
						job.put("backgroundColor", "rgb(91, 9, 9)");
						job.put("borderColor", "rgb(91, 9, 9)");
					}
				}else{
					if(job.get("completeness").equals("complete")){
						job.put("backgroundColor", "rgb(0,119,29)");
						job.put("borderColor", "rgb(0,119,29)");
					}else if(job.get("completeness").equals("incomplete")){
						job.put("backgroundColor", "rgb(91, 9, 9)");
						job.put("borderColor", "rgb(91, 9, 9)");
					}
				}
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getSurveys()");
			e.printStackTrace();
		}
		
		return jArray;
	}
	private String getInstitutionCity(int institutionID){
		String name = null;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT city FROM institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				name = rs.getString(1);
			}else{
				name = "No City";
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getInstitutionCity()");
			e.printStackTrace();
		}
		
		return name;
	}
	private String getInstitution(int institutionID){
		String name = null;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				if(rs.getString(10) == null){
					name = rs.getString(3) + " - No City";
				}else{
					name = rs.getString(3) + " - " + rs.getString(10);
				}
			}else{
				name = "None";
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getInstitution()");
			e.printStackTrace();
		}
		return name;
	}
	
	private ArrayList<String> getAccreditorAffiliation(int accreditorID){
		ArrayList<String> aff = new ArrayList<String>();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT institutionID, position FROM work WHERE accreditorID = ? and date_finished IS NULL");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			aff.add(getAccreditor(accreditorID));
			if(!rs.next() || accreditorID == 0){
				aff.add("No Affiliation");
				aff.add("N/A");
			}else{
				aff.add(getInstitution(rs.getInt(1)));
				
				aff.add(rs.getString(2));
			}
			aff.add(getAccreditorCity(accreditorID));
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getAccreditorAffiliation()");
			e.printStackTrace();
		}
		return aff;
	}
	
	private JSONArray getPS(int surveyID){
		JSONArray programSurvey = new JSONArray();
		JSONArray programArea = new JSONArray();
		JSONObject job = new JSONObject();
		String temp;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `PSID`,`survey_type`, `SPID`, `valid_thru`, `currentDecisionBy` , `boardApprovalDate` FROM `program-survey` WHERE surveyID = ?");
			ps.setInt(1, surveyID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("PSID", rs.getInt(1));
				job.put("surveyType", rs.getString(2));
				job.put("programName", getProgram(rs.getInt(3)));
				job.put("decisionBy", rs.getString(5));
				rs.getString(6);
				if(!rs.wasNull()){
					job.put("boardApprovalDate", formatDate(rs.getString(6)));

				}else{
					job.put("boardApprovalDate", "");
				}
				rs.getDate(4);
				if(!rs.wasNull()){
					job.put("valid_thru", formatDate(rs.getString(4)));

				}else{
					job.put("valid_thru", "");
				}
				programArea = getPA(rs.getInt(1));
				job.put("areas", programArea);
				int i = ((JSONArray) job.get("areas")).length();
				for(int j = 0; j<i;j++){
					String dec = ((JSONObject) ((JSONArray) job.get("areas")).get(j)).get("confirmation").toString();
					if ((dec.equals("Not Available") || dec.equals("Unconfirmed")) && !job.has("completeness")){
						job.put("completeness", "incomplete");
					}
				}
				
				if(!job.has("completeness")){
					job.put("completeness", "complete");
				}
				job.put("decisionJSON", getDecisionJSON(rs.getInt(1)));
				programSurvey.put(job);
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getPS()");
			e.printStackTrace();
		}
		return programSurvey;
	}
	
	private String getProgram(int SPID){
		String title = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `school-program` WHERE SPID = ?");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			title = rs.getString(9);
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getProgram()");
			e.printStackTrace();
		}
		
		return title;
	}
	
	private JSONArray getDecisionJSON(int PSID){
		JSONArray decisionJSON = new JSONArray();
		JSONObject job = new JSONObject();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `decisionID`, `decisionBy`, `decision`, `valid_thru`, `remarks`, `for_interim`, `for_consultation`, `for_progressReport` , `PSID`, `optionID` FROM `decisions` WHERE PSID = ?");
			ps.setInt(1, PSID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("decisionID", rs.getInt(1));
				job.put("decisionBy", rs.getString(2));
				job.put("decision", rs.getString(3));
				job.put("valid_thru", rs.getString(4));
				job.put("remarks", rs.getString(5));
				job.put("for_interim", rs.getString(6));
				job.put("for_consultation", rs.getString(7));
				job.put("for_progressReport", rs.getString(8));
				job.put("PSID", rs.getInt(9));
				job.put("optionID",rs.getString(10));
				
				decisionJSON.put(job);
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getPS()");
			e.printStackTrace();
		}
		return decisionJSON;
	}
	
	
	private JSONArray getPA(int PSID){
		JSONArray programArea = new JSONArray();
		JSONObject job = new JSONObject();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM `program-area` WHERE PSID = ?");
			ps.setInt(1, PSID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("accreditorID", rs.getInt(3));
				int accID = rs.getInt(3);
				if(rs.wasNull()){
					job.put("accreditor", "None");

				}else{
					job.put("accreditor", getAccreditor(accID));
					ArrayList<String> affs = getAccreditorAffiliation(accID);
					job.put("accreditorInstitution", affs.get(1));
					job.put("accreditorPosition", affs.get(2));
					job.put("accreditorCity", affs.get(3));
				}
				job.put("areaID", rs.getInt(2));
				job.put("area", getArea(rs.getInt(2)));
				job.put("position", rs.getString(4));
				job.put("confirmation", rs.getString(5));
				programArea.put(job);
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getPS()");
			e.printStackTrace();
		}
		return programArea;
	}
	
	private String getArea(int areaID){
		String area = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM areas WHERE areaID = ?");
			ps.setInt(1, areaID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			area =  rs.getString(1);
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getTitle()");
			e.printStackTrace();
		}
		
		return area;
	}
	
	private String getAccreditorCity(int accreditorID){
		String acc = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT city FROM accreditors WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			if(rs.next() && accreditorID != 0){
				acc = rs.getString(1);

			}else{
				acc = "Unknown";
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getAccreditorCity()");
			e.printStackTrace();
		}
		
		return acc;
	}
	private String getAccreditor(int accreditorID){
		String acc = new String();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM accreditors WHERE accreditorID = ?");
			ps.setInt(1, accreditorID);
			ResultSet rs = ps.executeQuery();
			if(rs.next() && accreditorID != 0){
				acc =  rs.getString(2) + ", " + rs.getString(3) + " " + rs.getString(4);
			}else{
				acc = "None";
			}
			
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getTitle()");
			e.printStackTrace();
		}
		
		return acc;
	}
	private String getTitle(int institutionID){
		String title = new String();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
			title = rs.getString(18);
			}else{
				title = "N/A";
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getTitle()");
			e.printStackTrace();
		}
		
		return title;
	}

public void addSurveyArea(String PSID,String areaID){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("INSERT INTO `program-area`(PSID,areaID,accreditorID,position,attendance_confirmation) Values(?,?,null,'Accreditor','Unconfirmed')");
		ps.setInt(1, Integer.parseInt(PSID));
		ps.setInt(2, Integer.parseInt(areaID));
		ps.executeUpdate();
		
	} catch (Exception e){
		System.out.println("Error in SurveyUtil:getTitle()");
		e.printStackTrace();
	}
}
	
public int getSystemID(int institutionID){
	int id = 0;
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT systemID FROM institutions WHERE institutionID = ?");
		ps.setInt(1, institutionID);
		ResultSet rs = ps.executeQuery();
		rs.next();
		id = rs.getInt(1);
		
	} catch (Exception e){
		System.out.println("Error in SurveyUtil:getTitle()");
		e.printStackTrace();
	}
	
	return id;
}



public int addNewProgram(int surveyID, int SPID){
	int temp = 0;
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("INSERT INTO `program-survey` (surveyID, SPID, `survey_type`) VALUES (?, ?, ?)");
		ps.setInt(1, surveyID);
		ps.setInt(2, SPID);
		ps.setString(3, "Preliminary");
		ps.executeUpdate();
		
		ps = conn.prepareStatement("SELECT LAST_INSERT_ID()");
		ResultSet rs = ps.executeQuery();
		rs.next();
		int PSID = rs.getInt(1);
		
		temp = PSID;
		
		
	} catch (Exception e){
		System.out.println("Error in SurveyUtil:addNewProgram()");
		e.printStackTrace();
	}
	return temp;
}

public JSONArray getConfirmationSurvey(int SurveyID){
	JSONArray jArray = new JSONArray();
	JSONObject job = new JSONObject();
	
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT * FROM surveys WHERE `surveyID` = "+SurveyID);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			job = new JSONObject();
			JSONArray programSurvey = new JSONArray();
			job.put("id", rs.getInt(1));
			job.put("title", getTitle(rs.getInt(6)));
			job.put("institutionName", getInstitution(rs.getInt(6)));
			job.put("systemID", getSystemID(rs.getInt(6)));
			job.put("start", rs.getString(2));
			job.put("endDate", rs.getString(3));
			job.put("dateRequested", rs.getString(5));
			job.put("dateApproved", rs.getString(4));
			programSurvey = getPS(rs.getInt(1));
			
			job.put("programs", programSurvey);
			
			
			jArray.put(job);
			
		}
	} catch (Exception e){
		System.out.println("Error in SurveyUtil:getSurveys()");
		e.printStackTrace();
	}	
	return jArray;
}

public void confirmAttendance(int PSID,int areaID,int accID){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET `attendance_confirmation` = ? WHERE accreditorID=? AND PSID = ? AND areaID = ?");
		ps.setString(1, "Confirmed");
		ps.setInt(2, accID);
		ps.setInt(3, PSID);
		ps.setInt(4, areaID);
		ps.executeUpdate();
		
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:updateProgram()");
	
		e.printStackTrace();
	}
	
}

public void deleteSurvey(int surveyID){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("DELETE from surveys WHERE surveyID = ?");
		ps.setInt(1, surveyID);
		ps.executeUpdate();
		
		ps = conn.prepareStatement("SELECT * from `program-survey` WHERE surveyID = ?");
		ps.setInt(1, surveyID);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			ps = conn.prepareStatement("DELETE from `program-area` WHERE PSID = ?");
			ps.setInt(1, rs.getInt(1));
			ps.executeUpdate();
		}
		
		ps = conn.prepareStatement("DELETE from `program-survey` WHERE surveyID = ?");
		ps.setInt(1, surveyID);
		ps.executeUpdate();
		
	} catch (Exception e){
		System.out.println("Error in SurveyUtil:deleteSurvey()");
		e.printStackTrace();
	}
}

private static String formatDate(String date){
	String format = "Date Error";
	String month = "";
	String day;
	String year;
	if((date == null) || (date.equals(""))||(date.equals(" ")) ){}else{
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

//	parts = parts[1].split(",");
	day = parts[2];
	
	format = month + " " + day + ", "+ year;
	}
	return format;
}

}
