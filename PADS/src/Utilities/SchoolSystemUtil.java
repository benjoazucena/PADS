package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.Connection;

import Models.SchoolSystem;

public class SchoolSystemUtil {
	
private DBUtil db;
public SchoolSystemUtil(){
	db = new DBUtil();
}

public SchoolSystem getSchoolSystem(int ssID){
	SchoolSystem temp = new SchoolSystem();
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT systemID, name, date_joined FROM `school-systems` WHERE systemID = "+ ssID +"");
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			temp = new SchoolSystem(rs.getInt(1),rs.getString(2), rs.getString(3));
					
		}
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:getSchoolSystems()");
		e.printStackTrace();
	}
	
    return temp;
}


public ArrayList<SchoolSystem> getSchoolSystems(){
	ArrayList<SchoolSystem> schoolsystems = new ArrayList<SchoolSystem>();
	SchoolSystem temp = new SchoolSystem();
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT systemID, name, date_joined FROM `school-systems`  ORDER BY `name`");
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			//constructor is (int accreditorID, String name, String institution, String discipline, String primaryArea, 
			// String secondaryArea, int totalSurveys, String city)
			//db returns accreditorID, lastname, firstname, midlename, honorifics, 
			//email, num_surveys, date_trained, contact, address, city, country, venue_trained
			temp = new SchoolSystem(rs.getInt(1),rs.getString(2), rs.getString(3));
			temp.setNumberOfInstitutions(getInstitutionCount(temp.getSchoolSystemID()));
			schoolsystems.add(temp);
		}
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:getSchoolSystems()");
		e.printStackTrace();
	}
	
    return schoolsystems;
}

public int getInstitutionCount(int ID){
	int count=0;
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT Count(*) FROM `institutions` WHERE `systemID` = ?");
		ps.setInt(1,ID);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt(1);
		
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:getSchoolSystems()");
		e.printStackTrace();
	}
	
    return count;
}


public JSONArray getSystems(){
	JSONArray jArray = new JSONArray();
	JSONObject job = new JSONObject();
	
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("SELECT systemID, name FROM `school-systems`  ORDER BY `name`");
		ResultSet rs = ps.executeQuery();
		System.out.println("jugjug lang");
		while(rs.next()){
			job = new JSONObject();
			job.put("systemID", rs.getInt(1));
			job.put("systemName", rs.getString(2));
			jArray.put(job);
			System.out.println(rs.getInt(1) + rs.getString(2) + "jugjug");
			
		}
	} catch (Exception e){
		System.out.println("Error in SchoolSystemUtil:getSystems()");
		e.printStackTrace();
	}
	
	return jArray;
}

public void addSchoolSystem(String name, String date_joined){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("INSERT INTO `school-systems` (name, date_joined) VALUES (?,?)");
		ps.setString(1, name);
		ps.setString(2, date_joined);
		System.out.println(name + " " + date_joined +"!!!!!!!!!!!!!!");	
		ps.executeUpdate();
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:addSystem()");
		e.printStackTrace();	
	}
}

public void editSchoolSystem(int systemID, String name, String date_joined){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("UPDATE `school-systems` SET name=?, date_joined=? WHERE systemID=?");
		ps.setString(1, name);
		ps.setString(2, date_joined);
		ps.setInt(3,systemID);
		System.out.println(name + " " + date_joined +"!!!!!!!!!!!!!!");	
		ps.executeUpdate();
	} catch (Exception e){
		System.out.println("Error in ProgramUtil:addSystem()");
		e.printStackTrace();	
	}
}

public void deleteSchoolSystem(int schoolSystemID){
	try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("DELETE from `school-systems` WHERE systemID = ?");
		ps.setInt(1, schoolSystemID);
		ps.executeUpdate();
	} catch (Exception e){
		System.out.println("Error in SchoolSystemUtil:deleteSchoolSystem()");
		e.printStackTrace();
	}
}


//public void editProgram(int programID, String name){
//	try{
//		Connection conn = db.getConnection();
//		PreparedStatement ps = conn.prepareStatement("UPDATE programs SET name = ? WHERE programID = ?");
//		ps.setString(1, name);
//		ps.setInt(2, programID);
//		ps.executeUpdate();
//	} catch (Exception e){
//		System.out.println("Error in ProgramUtil:editProgram()");
//		e.printStackTrace();
//	}
//}

}
