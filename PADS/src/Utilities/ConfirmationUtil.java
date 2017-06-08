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
	
	public void updateDecision(String dteam, String remarks_team, String dcommission, String remarks_commission, String dboard, String remarks_board, String valid_thru, String fi_team, String fc_team, String fp_team, String fi_commission, String fc_commission, String fp_commission, String fi_board, String fc_board, String fp_board,int PSID, String dateApproved){
		System.out.println(dateApproved+"DateApprovved---------------------");
		System.out.println(valid_thru+"VALIDITYYY---------------------");
		updateBy(dteam,remarks_team,fi_team,fc_team,fp_team,PSID,"Team");
		updateBy(dcommission,remarks_commission,fi_commission,fc_commission,fp_commission,PSID,"Commission");
		updateBy(dboard,remarks_board,fi_board,fc_board,fp_board,PSID,"Board");
		if(dateApproved!=null&&dateApproved!=""){
			updateCurrentDecisionBy("Board", PSID,dateApproved, valid_thru);
			
		}
		
	}
	
	public void updateBy(String decision, String remarks, String fi, String fc, String fp, int PSID, String by){
		
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `decisions` SET decision=?, `remarks`=? , `for_interim`=? ,`for_consultation`=?, `for_progressReport`=?  WHERE  PSID= ? AND `decisionBy`=?");
			ps.setString(1, decision);
			System.out.println(remarks);
			ps.setString(2, remarks);
			ps.setString(3, fi);
			ps.setString(4, fc);
			ps.setString(5, fp);
			ps.setInt(6, PSID);
			ps.setString(7, by);
			ps.executeUpdate();
//			conn.close();
			System.out.println("Successful on updating decision of "+by);
		} catch (Exception e){
			System.out.println("Error in ConfirmationUtil:updateBy()");
			e.printStackTrace();
		}		
	}
	
	
	public void changeAccreditor(int newAccID,int PSID,int areaID, int oldAccID){
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-area` SET accreditorID=? WHERE  PSID=? AND areaID=? AND accreditorID=?");
			ps.setInt(1, newAccID);
			ps.setInt(2, PSID);
			ps.setInt(3, areaID);
			ps.setInt(4, oldAccID);
			
			ps.executeUpdate();
			conn.close();
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
		
		
	}
	
public void updateCurrentDecisionBy(String by, int PSID, String boardApproval, String valid_thru){
				
		try{
			String queryPortion = "`valid_thru` =?,";
			Connection conn = db.getConnection();
			if(valid_thru==""|| valid_thru == null){
				queryPortion = "";
			}
			else{
				queryPortion= "`valid_thru` ="+valid_thru+",";
			}
			PreparedStatement ps = conn.prepareStatement("UPDATE `program-survey` SET `currentDecisionBy` =?, "+queryPortion+"  `boardApprovalDate`=? WHERE  PSID= ?");
			ps.setString(1, by);
			ps.setString(2, boardApproval);
			ps.setInt(3, PSID);
			ps.executeUpdate();
			conn.close();
			
		} catch (Exception e){
			System.out.println("Error in ProgramUtil:updateProgram()");
			e.printStackTrace();
		}
		
	}

}
