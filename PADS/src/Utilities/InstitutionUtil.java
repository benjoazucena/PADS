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

import Models.Institution;

public class InstitutionUtil {
	private DBUtil db;
	public InstitutionUtil(){
		db = new DBUtil();
	}
	
	
	public JSONArray getInstitutionsJSON(int systemID){
		JSONArray jArray = new JSONArray();
		JSONObject job = new JSONObject();
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT institutionID, name, city FROM `institutions` WHERE systemID = ?  ORDER BY `name`");
			ps.setInt(1, systemID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				job = new JSONObject();
				job.put("institutionID", rs.getInt(1));
				job.put("institutionName", rs.getString(2) + " - " + rs.getString(3));
				jArray.put(job);
				
			}
		} catch (Exception e){
			System.out.println("Error in InstitutionUtil:getInstitutionsJSON()");
			e.printStackTrace();
		}
		
		return jArray;
	}
	
	private String getSchoolSystemName(int ID){
		String name="";
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT `name` FROM `school-systems` where `systemID`=?");
			ps.setInt(1, ID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){				
			
				name = rs.getString(1);
				System.out.println("Checking schoolsystemName: "+ name);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
		return name;
	}
	
	public ArrayList<Institution> getInstitutions(){
		ArrayList<Institution> institutions = new ArrayList<Institution>();
		Institution temp = new Institution();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions a  ORDER BY `name`");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				//constructor is (int accreditorID, String name, String institution, String discipline, String primaryArea, 
				// String secondaryArea, int totalSurveys, String city)
				//db returns accreditorID, lastname, firstname, midlename, honorifics, email, num_surveys, 
				//date_trained, contact, address, city, country, venue_trained, primaryAreaID, 
				//secondaryAreaID, discipline
			
				System.out.println(rs.getString(3));
				temp = new Institution(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18));
				temp.setSchoolsystemName(getSchoolSystemName(rs.getInt(2)));
				
				institutions.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return institutions;
	}
	
	public ArrayList<Institution> getSchoolSystemInstitutions(int systemID){
		ArrayList<Institution> institutions = new ArrayList<Institution>();
		Institution temp = new Institution();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions a WHERE `systemID` = ?  ORDER BY `name`");
			ps.setInt(1, systemID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				//constructor is (int accreditorID, String name, String institution, String discipline, String primaryArea, 
				// String secondaryArea, int totalSurveys, String city)
				//db returns accreditorID, lastname, firstname, midlename, honorifics, email, num_surveys, 
				//date_trained, contact, address, city, country, venue_trained, primaryAreaID, 
				//secondaryAreaID, discipline
			
				System.out.println(rs.getString(3));
				temp = new Institution(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18));
				institutions.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return institutions;
	}
	
	public Institution getInstitution(int instID){
		Institution temp = new Institution();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM institutions a where a.institutionID ="+instID+"");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			
				
				temp = new Institution(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18));
				
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return temp;
	}
	
	
	
	public void addInstitution(String ssName, String institutionName, String institutionAcronym, String address , String city , String country ,
			String website , String contactNumber , String fax , String institutionHead , String position , String headEmail ,
			String contactPerson , String contactPosition , String contactEmail , String membershipDate){
		try{
		
			String dateBuild = formatDate(membershipDate);
			
			
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO institutions (systemID, name, head, position, email, address, status, date_added, city, fax, contact_person, contactPosition, contact_number, website, country, contactEmail, acronym) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			int ssID_int = Integer.parseInt(ssName);
			ps.setInt(1, ssID_int);
			ps.setString(2, institutionName);
			ps.setString(6, address);
			ps.setString(9, city);
			ps.setString(15, country);
			ps.setString(14, website);
			ps.setString(13, contactNumber);
			ps.setString(10, fax);
			ps.setString(3, institutionHead);
			ps.setString(4, position);
			ps.setString(5, headEmail);
			ps.setString(11, contactPerson);
			ps.setString(12, contactPosition);
			ps.setString(16, contactEmail);
			ps.setString(7, "Preliminary Visit");
			ps.setString(8, dateBuild);
			ps.setString(17, institutionAcronym);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in InstitutionUtil:addInstitution()");
			e.printStackTrace();	
		}
	}
	
	public void editInstitution(int institutionID, String ssName, String institutionName, String institutionAcronym, String address , String city , String country ,
			String website , String contactNumber , String fax , String institutionHead , String position , String headEmail ,
			String contactPerson , String contactPosition , String contactEmail , String membershipDate){
		try{
			String dateBuild = formatDate(membershipDate);
			
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE institutions SET systemID=?, name=?, head=?, position=?, email=?, address=?, status=?, date_added=?, city=?, fax=?, contact_person=?, contactPosition=?, contact_number=?, website=?, country=?, contactEmail=?, acronym=? Where institutionID=?");
			int ssID_int = Integer.parseInt(ssName);
			ps.setInt(1, ssID_int);
			ps.setString(2, institutionName);
			ps.setString(6, address);
			ps.setString(9, city);
			ps.setString(15, country);
			ps.setString(14, website);
			ps.setString(13, contactNumber);
			ps.setString(10, fax);
			ps.setString(3, institutionHead);
			ps.setString(4, position);
			ps.setString(5, headEmail);
			ps.setString(11, contactPerson);
			ps.setString(12, contactPosition);
			ps.setString(16, contactEmail);
			ps.setString(7, "Preliminary Visit");
			ps.setString(8, dateBuild);
			ps.setString(17, institutionAcronym);
			ps.setInt(18, institutionID);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in InstitutionUtil:addInstitution()");
			e.printStackTrace();	
		}
	}
	
	
	public void addProgramToInst(String specific, int generalID, int instID, String level){
		try{
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String strDate = dateFormat.format(date);
			
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO `school-program` (programID, institutionID, level, date_added, degree_name) VALUES (?,?,?,?,?)");
		
			ps.setInt(1, generalID);
			ps.setInt(2, instID);
			ps.setString(3, level);
			
			ps.setString(5, specific);
			ps.setString(4, strDate);
			
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in InstitutionUtil:addProgramToInstitution()");
			e.printStackTrace();	
		}
		
	}
	
	public void updateProgramToInst(String SPID, String level){
		try{
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!00000000"+level);
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `school-program` SET level=? WHERE `SPID`=?");
						
			ps.setString(1, level);
			ps.setString(2, SPID);
					
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in InstitutionUtil:addProgramToInstitution()");
			e.printStackTrace();	
		}
		
	}
	
	public void deleteInstitution(int institutionID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("DELETE from institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ps.executeUpdate();
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:deleteAccreditor()");
			e.printStackTrace();
		}
	}
	
	private static String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if(date==null||date.equals("")||date.equals(" ")){}
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
