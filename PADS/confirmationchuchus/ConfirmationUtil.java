package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;

import Models.Program;
import Models.SchoolProgram;

public class ConfirmationUtil {
	
	private DBUtil db;
	public ConfirmationUtil(){
		db = new DBUtil();
	}
	private void checkNotif(int accID){
		
		
		
		
	}
	
	public void confirmAttendance(int PSID,int areaID, int accID){
		
		
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET attendance_confirmation='Attended' WHERE  PSID= "+ PSID+" AND areaID="+areaID+" AND accreditorID="+accID+"");
		
			ps.executeUpdate();
			conn.close();
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
		
	}
	
	public void updateDecision(String decision, String remarks, String nextSched, int PSID){
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-survey` SET board_decision='WITH DECISION', `valid_thru`= "+nextSched+" , `decision_by`= 'Team' WHERE  PSID= "+ PSID);
			ps.executeUpdate();
			conn.close();
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
		
		
	}
	
	public void changeAccreditor(int accID,int PSID,int areaID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET accreditorID=? WHERE  PSID=? AND areaID=? AND accreditorID=?");
			ps.setInt(1, accID);
			ps.setInt(2, PSID);
			ps.setInt(3, areaID);
			ps.setInt(4, accID);
			ps.executeUpdate();
			conn.close();
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
		
		
	}

}
